Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWJDUQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWJDUQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWJDUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:16:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:62706 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751078AbWJDUQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:16:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eiCp/w3bRqVYjbKyNoG+Clyz0DskvxMe+/Pi94jUUNzIdD3KwG6OEBlmn/NImN+vhBYHBuQMjyiZUwiN8UDxAmPjdwdd7hHUKLcYJD1BVJWsTW9sPSQusbyGwQNhrGKejLXhzPvaXD2B+8oaS5u7HrYtmRUNIK4d68Z9QlfIDeY=
Message-ID: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com>
Date: Wed, 4 Oct 2006 22:16:41 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Funky "Blue screen" issue while rebooting from X with 2.6.18-git21
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange "problem" with 2.6.18-git21 that I've never had with
any previous kernel. If I open up an xterm in X, su to root and
'reboot' (or 'shutdown -r now') I instantly get a blue screen that
persists until the box actually reboots.
With previous kernels (all that I can remember, latest tested being
2.6.18-git15 (then I jumped from -git15 to -git21)) what happened was
that X would die and I would be returned to text mode so that I could
actually see all the shutdown messages from my init scripts (which is
very nice).

I don't really know what info would be relevant to provide regarding
this issue, so please ask for any info you need.

I can start testing kernels between 2.6.18-git15 and 2.6.18-git21
and/or  doing git bisects if anyone thinks it will be useful. If you
want that, please speak up, since I would rather not build and
test-boot a lot of kernels for no reason if nobody wants the info. But
if it will be useful I'll be happy to do it.

Anyway, there's a bug somewhere, let's squash it ;-)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
