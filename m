Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTAINfb>; Thu, 9 Jan 2003 08:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbTAINfa>; Thu, 9 Jan 2003 08:35:30 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:45771 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266622AbTAINfa>; Thu, 9 Jan 2003 08:35:30 -0500
Date: Fri, 10 Jan 2003 02:43:57 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Andres Salomon <dilinger@voxel.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.x inspiron touchpad breakage
Message-ID: <39260000.1042119837@localhost.localdomain>
In-Reply-To: <pan.2003.01.09.08.27.53.688647@voxel.net>
References: <pan.2003.01.09.08.27.53.688647@voxel.net>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works for me on an Inspiron 8000.  The trackpoint does not, which is a 
known bug.  Of course, the 3800 might be different...

Have you been bitten by the input layer configuration issue?  Here's what I 
have:

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

Andrew

--On Thursday, January 09, 2003 03:27:54 -0500 Andres Salomon 
<dilinger@voxel.net> wrote:

> 2.5.54 and 2.5.55 do not appear to initialize the touchpad on my Dell
> Inspiron 3800.  No mouse device is detected until I plug a normal ps/2
> mouse into the laptop.  I assume this is some weird bios thing.  2.4.x
> works fine with it.  Does anyone have suggestions about where to look for
> any changed in the 2.5 series that might've broken it, or any patches that
> fix it?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


