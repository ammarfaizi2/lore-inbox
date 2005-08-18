Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVHRWLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVHRWLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVHRWLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:11:32 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:6097 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932490AbVHRWLc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:11:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LS7/uAVg8DDMwBjX6VdNRSepWg88pa3mWWXCGQAgEY6Vcc3yhCXgv/gSYZfLpzWCQ1VYTPgA3ydWoSazvsHON2JcIw7Ja/PwIW5TwsHhPcMwaYujxok1rd6cdw5voWz6Fsd2UxedXn2iOdGey2pMgCDFkl5tOyGDYnyneGfzFTg=
Message-ID: <c26b9592050818151154ff1a89@mail.gmail.com>
Date: Fri, 19 Aug 2005 03:41:30 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux under 8MB
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

              For the last couple of days, I have been trying to set
up linux kernel under 8MB. So far I have set up a linux 2.4.31, which
just works under 8MB. However, I would be grateful if someone could
help with the following queries

a)          Is linux2.4 just the right option? What about linux 2.0.x?
Or for that matter even <2.0
b)          What are the specific issues that are to be considered
while compiling an old kernel on a newer setup? I ask this because I
compiled my current setup on a 2.6.11 machine and while doing "make
modules_install", I got errors from depmod[%], complaining about
depmod.old.  I had to kludge my way through by setting up a link from
depmod.old to depmod.



[%] Not to mention that on a FC4 machine, gcc 4,x meowed  while
compiling the kernel.


TIA,
-- 
Imanpreet Singh Arora
                  If I am given six hours to chop a tree, I will spend
the first four sharpening the knife.
                         -- A.L.
