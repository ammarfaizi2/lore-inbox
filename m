Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269593AbRIGA1T>; Thu, 6 Sep 2001 20:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269770AbRIGA1L>; Thu, 6 Sep 2001 20:27:11 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:32764 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S269593AbRIGA0u>; Thu, 6 Sep 2001 20:26:50 -0400
Date: Thu, 6 Sep 2001 16:27:06 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: "D. Stimits" <stimits@idcomm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial Ports
In-Reply-To: <3B96C783.8BC8E29B@idcomm.com>
Message-ID: <Pine.LNX.4.33.0109061624320.1443-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2001, D. Stimits wrote:

> Make sure your bios is set to "not plug-n-play aware". I have a
> Supermicro Dual P3 board that works fine (actually, 2) with serial mice.
> In the case of the modem serial port, I have to use setserial to get the
> characteristics I want, plus the setserial options seem to require
> speed_normal and skip_test to work correctly. Incidentally, if your
> board is based on the i840 chipset, you'll have to run noapic or it will
> die under some circumstances, such as heavy disk load, or rapid
> mount/umount of any filesystem (even a cdrom).
>
> D. Stimits, stimits@idcomm.com

I have noticed that serial ports change IRQ to either 3 or 4. There is no
reason for this behavior. I have created a perl script to create a log
containing the irqs assigned and their ioports. Is there anything else I
could log that might unmask the problem?

So far if the serials are assigned to IRQ 4 then the sync with the palm
pilot doesn't work (/dev/pilot = /dev/ttyS0). If its IRQ 3 then it does.

Stephen

