Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWAYWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWAYWaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWAYWaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:30:07 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:18046 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932189AbWAYWaD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:30:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ORZEVklVJqyY30K+924S/OrAu8L+jh1pcMaDvuvjG8qnI3/dKBXDg16ei66kuJuOb5m8cmXx3z54vdOJohjcfVn/oVei820tZfAkb944bVBQ7PU6kOknXZjDl1HJJb7/vEQeiy7iXTJwqByPZV9GaXK7xzVvWfqpT40Y/f2UaKk=
Message-ID: <5a2cf1f60601251430k5823e7dald12c9b5f8bc297be@mail.gmail.com>
Date: Wed, 25 Jan 2006 23:30:02 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] make it easy to test new kernels
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linux user from a long time, I feel that I am not doing enough to help
Linux improve. In particular, I would like to test new Linux kernels
more often.

Unfortunately, as time pass buy, I have less and less time to play
with setting up my machines. I cannot spend time compiling and booting
a kernel for every machine I have access to, nor take the risk to
crash a machine I depend upon.

So although I have access to 5-10 machines easily, I end up testing
kernels on 2 machines only, 5-6 times per year per machine (i.e. for
each kernel release). The other machines for their distro specific
kernel upgrades (or test a live distro)...

The only machine I can play with daily is my desktop. But as a
developer, it takes me several minutes to go from a cold boot to a
desktop suitable for my work. I usually have many graphical
applications (browser, IDE, plenty of shells, IM tools), servers
(database, web server, ...). So I usually don't reboot my desktop for
weeks. (I really hope that software suspend will finally help me to
speed this up someday.)

I could compile a new kernel everyday. It's not too hard a process to
automate. But today, I cannot take the cost and risk of rebooting my
machine. It just takes too much time.

Now I am wondering if there's a way to solve this. How can we make the
testing of new kernels easier?

A kernel.org live distro with integrated issue reporting could be an
idea, but it wouldn't show particular desktop application breakage.
And I see a Gnome/KDE/XFCE flame war ready to start...

Now, will all these talks about virtualization, I wonder if it will be
possible one day to just download a new virtualized test OS and test
it without rebooting the main one. I could always allocate 10 G to a
test system on my disk. As long as I don't have to reboot.

But maybe I am focusing on the wrong approach?
Linux developers, what would be the thing that takes no more than 4-5
min per day that people like me could do with our machines to help you
improve Linux?

Jerome
