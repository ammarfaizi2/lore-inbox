Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWATRby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWATRby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWATRby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:31:54 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:49348 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751108AbWATRbx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:31:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MVFf2TBa+qI7srJw3ckjGhnAWFkIci3MMdUWHd+DClmyjYys3lMQP3SaW0YWLW9FyfmlmXp/ZPH902PGrYfZ9F9uSQoAp6Cvi53azWQoBQZIemGKWI12QwKKQFDo3U8EVXM8Ge8/uQKvKrwi0hXBwLyPGhi3WhtLk7XHWE0H7ek=
Date: Fri, 20 Jan 2006 18:31:31 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Michael Loftis <mloftis@wgops.com>
Cc: marc@osknowledge.org, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-Id: <20060120183131.848bfb2a.diegocg@gmail.com>
In-Reply-To: <0B1B67D811A178FB3BE70C96@d216-220-25-20.dynip.modwest.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	<20060120155919.GA5873@stiffy.osknowledge.org>
	<B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
	<20060120163551.GC5873@stiffy.osknowledge.org>
	<0B1B67D811A178FB3BE70C96@d216-220-25-20.dynip.modwest.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 20 Jan 2006 10:06:50 -0700,
Michael Loftis <mloftis@wgops.com> escribió:

> The one machine I've got running 2.6+devfs under debian chokes in initrd 
> with an inability to find devfs during boot so I had to go back to static 
> /dev entries for it since atleast in sarge right now I'm not seeing a 

Were you using a debian-provided kernel? 

> quick-and-easy way to get devfs like support bundled via mkinitrd, but I 
> haven't looked, and I shouldn't have to.  It shouldn't have gone away in a 

Have you updated other packages in your system? If you update the kernel, 
you should update the rest of the kernel-related userspace tools (mkinitrd 
is hardly "yet another userspace application"). Debian default kernel
is 2.4 and only provides a 2.6.8-based kernel (2.6.8 was released in august
2004, 17 months ago) as an alternative, and the debian guys put this
in the release notes:

http://www.debian.org/releases/stable/i386/release-notes/ch-information.en.html#s-upgrade-to-2.6

"[...] Upgrading to a 2.6 kernel from an earlier version is therefore
not a process to be undertaken lightly" and "5.2.4 Switching to 2.6 may
activate udev"
