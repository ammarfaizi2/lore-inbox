Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWIOIup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWIOIup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWIOIup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:50:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34380 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750765AbWIOIup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:50:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SMYLuppG4QJYdK+zXXjKLGoHvkJU1InOVaQcGtPu+ZD4/GIMGKopkzkRbjmpOZNU/lu+DeMvTQsu+7L/Yfqt2REIfW+ukt9sm2TPYQcEyBmaCvk8IuzgtGG8rTZvci1G0HMAiCbsZMh4ddeWea7kNb+YAPX0G9/TPZQUa6Ujwxg=
Message-ID: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com>
Date: Fri, 15 Sep 2006 01:50:43 -0700
From: "Sandeep Kumar" <sandeepksinha@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Efficient Use of the Page Cache with 64 KB Pages
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
I am a newbie and I just read a document with the idea for changes in
page cache management for 64 Bit machines. This has been taken from
Linux symposium 2006, ottawa.

In order for 64-bit processors to efficiently use large address spaces
while maintaining lower TLB miss rates, the Linux kernel can be
configured with base page sizes up to 64 KB. While this benefits
access to large memory segments and files, it greatly reduces the
number of smaller files that can be resident in memory at one time.
The idea proposes a change to the Linux kernel to allow file data to
be more efficiently stored in memory when the size of the file, or the
data at the end of a file, is significantly smaller than the page
size.

So, how far is this feature feasible for the linux main line kernel ?
Is, this feature already supported ?
-- 
Regards,
Sandeep





Winners expect to win in advance. Life is a self-fulfilling prophecy.
