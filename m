Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbSLaCeb>; Mon, 30 Dec 2002 21:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSLaCeb>; Mon, 30 Dec 2002 21:34:31 -0500
Received: from 115.8.237.216.globalpac.com ([216.237.8.115]:58506 "EHLO
	mail.yessos.com") by vger.kernel.org with ESMTP id <S267125AbSLaCea>;
	Mon, 30 Dec 2002 21:34:30 -0500
Message-ID: <3E110417.1050209@tmsusa.com>
Date: Mon, 30 Dec 2002 18:42:31 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Robert Ladd <scott@coyotegulch.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.52] NFS works with 2.4.20, not with Win2K/SFU
References: <FKEAJLBKJCGBDJJIPJLJMEMPDOAA.scott@coyotegulch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No telling what kind of odd bugs could be in
ms services for unix, I was not at all impressed
with what I saw of it at Linux world last Aug -
It seemed to be mostly a broken toy...

My experience suggests that you'll have much
better luck using samba for your unix-to-pc
connectivity needs.

Just a thought,

Joe

Scott Robert Ladd wrote:

>Heck if I know whose bug this is...
>
>One of my systems runs kernel 2.5.52; its NFS shares mount fine with my
>2.4.20 system, and the 2.4.20 shares mount properly on the 2.5.52 system.
>All's happy in Linuxland.
>
>Unfortunately, Windows is *not* happy. My system using Windows 2000
>w/"Services for Unix" can mount the NFS exports from the 2.4.20 machine --
>but while the Win2K box can *see* the 2.5.52 shares, it suffers terribly
>when trying to mount them -- sometimes locking up, sometimes telling me the
>share can't be found.
>
>Another oddity: The Win2k machine sees the 2.4.20 system by IP address, and
>the 2.5.52 system by name.
>
>I have the 2.5.52 kernel compiled for NFS4. Both the 2.5.52 system and
>2.4.20 have identical /etc/exports and /etc/hosts.
>
>I'm quite willing to lay this in the lap of those jolly folk in Redmond, but
>I was wondering if anyone knew of incompatibility between 2.5.52 NFS and
>Win2K/SFU.
>
>..Scott
>
>--
>Scott Robert Ladd
>Coyote Gulch Productions,  http://www.coyotegulch.com
>No ads -- just very free (and somewhat unusual) code.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


