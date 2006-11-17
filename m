Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933713AbWKQVEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933713AbWKQVEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933759AbWKQVEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:04:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:64795 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933713AbWKQVEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:04:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DtU32sL5uP+rc0vomIj5yJtGd6iH8c/DfM5EMKuw5FdERRsaaWWJxNONmgJEeOivfE/jgFqDftSjCYYT/+yvVbXlpRWsm9n2juD4FJJDIn9frikuHKbvi2VKUqi+AtMWlzki5m3mXCHi+yvtuXRumAqt+oJK53tsEb2HL+WpZX0=
Message-ID: <2625b9520611171304x213b3bc6h6e2a40d43ce4497c@mail.gmail.com>
Date: Fri, 17 Nov 2006 13:04:19 -0800
From: "Thushara Wijeratna" <thushw@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: some help in kernel debugging
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm following instructions at
http://kgdb.linsyssoft.com/quickstart.htm to get into kernel
debugging. Since it doesn't ask me to do a 'make modules;make
modules_install' on the test machine, I think I can't build a good
initrd image on the test machine (since mkinitrd requires a kernel
version which it checks under /lib/modules)?

What happens is that when I copy the kernel from my dev machine to
test, edit the test machine's grub.conf and reboot, I get a kernel
panic with message:

'not syncing: VFS: Unable to mount root fs on unknown-block(0,0)'

I added an initrd image, but since the kernel modules aren't installed
on the test machine, I gave the 2nd parameter to mkinitrd the version
of the kernel that is running on the test machine. I guess that's just
plain wrong - well the kernel still didn't boot.

Should I also install the same kernel (without the kgdb patch) on the
test machine as well?

This is my 1st attempt to debug the kernel and any help you can give
will be much appreciated  to get me going...

Thanks,
Thushara
