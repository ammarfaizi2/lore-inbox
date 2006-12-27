Return-Path: <linux-kernel-owner+w=401wt.eu-S1754657AbWL0Rux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbWL0Rux (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbWL0Rux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:50:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:43879 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbWL0Ruw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:50:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=c+NPq7ddAXFQ6ftzAf7FEuiLIih0xSEclA8qYGD8gn7xyui8tIImNPfmcU+4CpvohHgGnrLmqu4W2HeOQ2aqdDMslJ/tXSQPxSEQlFBxsJ1TaMcLlsrBfHeVXxy1Xr5mc9nx5jkJSOYnBwE7mp5x3uLyBtIyCXxgtVBDsl8hVa8=
Message-ID: <8bd0f97a0612270950i46137fccr9cd60d8ded7bcaee@mail.gmail.com>
Date: Wed, 27 Dec 2006 12:50:50 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] respect srctree/objtree in Documentation/DocBook/Makefile
Cc: "Andrew Morton" <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_71672_24928668.1167241850852"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_71672_24928668.1167241850852
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the KERNELDOC and DOCPROC variables are relative to the
$(srctree)/$(objtree) and expect to be run only from there ...
attached patch adds proper srctree/objtree prefixes to both variables
-mike

------=_Part_71672_24928668.1167241850852
Content-Type: application/octet-stream; name="linux-docbook-trees.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-docbook-trees.patch"
X-Attachment-Id: f_ew81op4l

aGF2ZSBLRVJORUxET0MgdXNlICQoc3JjdHJlZSkgYW5kIERPQ1BST0MgdXNlICQob2JqdHJlZSkK
ClNpZ25lZC1vZmYtYnk6IE1pa2UgRnJ5c2luZ2VyIDx2YXBpZXJAZ2VudG9vLm9yZz4KCmRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL0RvY0Jvb2svTWFrZWZpbGUgYi9Eb2N1bWVudGF0aW9uL0Rv
Y0Jvb2svTWFrZWZpbGUKaW5kZXggMzY1MjZhMS4uODY3NjA4YSAxMDA2NDQKLS0tIGEvRG9jdW1l
bnRhdGlvbi9Eb2NCb29rL01ha2VmaWxlCisrKyBiL0RvY3VtZW50YXRpb24vRG9jQm9vay9NYWtl
ZmlsZQpAQCAtNTMsOCArNTMsOCBAQCBpbnN0YWxsbWFuZG9jczogbWFuZG9jcwogCiAjIyMKICNF
eHRlcm5hbCBwcm9ncmFtcyB1c2VkCi1LRVJORUxET0MgPSBzY3JpcHRzL2tlcm5lbC1kb2MKLURP
Q1BST0MgICA9IHNjcmlwdHMvYmFzaWMvZG9jcHJvYworS0VSTkVMRE9DID0gJChzcmN0cmVlKS9z
Y3JpcHRzL2tlcm5lbC1kb2MKK0RPQ1BST0MgICA9ICQob2JqdHJlZSkvc2NyaXB0cy9iYXNpYy9k
b2Nwcm9jCiAKIFhNTFRPRkxBR1MgPSAtbSAkKHNyY3RyZWUpL0RvY3VtZW50YXRpb24vRG9jQm9v
ay9zdHlsZXNoZWV0LnhzbAogI1hNTFRPRkxBR1MgKz0gLS1za2lwLXZhbGlkYXRpb24K
------=_Part_71672_24928668.1167241850852--
