Return-Path: <linux-kernel-owner+w=401wt.eu-S1030199AbXAKC5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbXAKC5J (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 21:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbXAKC5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 21:57:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:12672 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030199AbXAKC5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 21:57:08 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hcJSbTYEdCKVQWRBw+WtzRoDPNElk83hWZ6mLBMiqre4bTHtJ5u9aA1TG4sHQF1/siMTXFVKDxHDBeTlK5OuskHfYRk3XqWUPBYpyaebFj1v7MwyIoob7W1Gg7M5h9OGn/ByqeK77iocBpMplGGOE6TE06l8XgDAnVlog4hNhWo=
Message-ID: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
Date: Thu, 11 Jan 2007 10:57:06 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: O_DIRECT question
Cc: "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       torvalds@osdl.org, mjt@tls.msk.ru
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Opening file with O_DIRECT flag can do the un-buffered read/write access.
So if I need un-buffered access, I have to change all of my
applications to add this flag. What's more, Some scripts like "cp
oldfile newfile" still use pagecache and buffer.
Now, my question is, is there a existing way to mount a filesystem
with O_DIRECT flag? so that I don't need to change anything in my
system. If there is no option so far, What is the right way to achieve
my purpose?

Thanks a lot.
-Aubrey
