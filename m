Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRKIUWL>; Fri, 9 Nov 2001 15:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280086AbRKIUWA>; Fri, 9 Nov 2001 15:22:00 -0500
Received: from omnis-mail.omnis.com ([216.239.128.28]:46354 "HELO omnis.com")
	by vger.kernel.org with SMTP id <S280056AbRKIUVo>;
	Fri, 9 Nov 2001 15:21:44 -0500
Message-ID: <3BEC3B3A.6040005@sh.nu>
Date: Fri, 09 Nov 2001 12:23:22 -0800
From: Daniel Ceregatti <vi@sh.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011010
X-Accept-Language: en-us
MIME-Version: 1.0
CC: vi@sh.nu, linux-kernel@vger.kernel.org
Subject: MS Natural keyboard extra keys using usb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First off, I do not subcribe to the kernel list, so if anyone responds
to this, please CC me at vi@sh.nu.

I've got an MS Natural keyboard plugged in via USB. I've mapped all the
"Internet Keys", those blue keys above the keyboard, in X using xmodmap.
I use them to control xmms, volume, spawn shells, etc.

Ever since 2.4.10, these keys have stopped working. I suspect it's some
issue with USB, as my mouse, an MS Intellimouse Optical, also stopped
working in X with that kernel. The fix for the mouse was to change the
protocol from NetmousePS/2 to ExplorerPS/2. I never use console, so I
don't know if it broke there too. Keep in mind here that the only thing
that changed was the kernel. Nothing in X changed. If I go back to
2.4.9, everything works as it did before. This problem exists with all
kernels between 2.4.10 and 2.4.13.

To further prove the usb theory, these mouse and keyboard issues have
been present in all the ac kernels since about 2.4.5-acX. I understand
that a lot of these ac changes were merged into 2.4.10. So it seems
logical to conclude that something that was merged from ac is the cause
of this.

I'm not a kernel programmer, so I have no idea how to troubleshoot this.
I've searched high and low for resolutions to this issue and have come
up blank. That is why I'm posting here.

Thanks,

Daniel Ceregatti

