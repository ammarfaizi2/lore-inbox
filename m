Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279790AbRKFQVy>; Tue, 6 Nov 2001 11:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279787AbRKFQVo>; Tue, 6 Nov 2001 11:21:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279717AbRKFQVf>; Tue, 6 Nov 2001 11:21:35 -0500
Date: Tue, 6 Nov 2001 11:21:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dana Lacoste <dana.lacoste@peregrine.com>
cc: linux-kernel@vger.kernel.org, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        roy@karlsbakk.net
Subject: RE: Mylex/Compaq RAID controller placement in config
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2863@ottonexc1.ottawa.loran.com>
Message-ID: <Pine.LNX.3.95.1011106111442.569A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Dana Lacoste wrote:

> > Well we could simplify it further by putting all
> > configuration options under a single menu called
> > "things". The controllers under block  dont have
> > drives appearing as /dev/sd*
> 
> I can understand the initial complaint, but I think it
> comes down to a problem of user vs. developer :
> 
> For example : All of the SCSI devices are block devices,
> aren't they?  So how come they're not under "block devices"
> in the menu?
> 

No, we have (Americal National Standard X3.131-1986) "sequential-access",
"printer", "processor", etc., SCSI devices. They are controlled using a
"command-block", however they are not "block" devices although the 
sequential-access device could be (like tape). My tape is /dev/st0, it's
a character device.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


