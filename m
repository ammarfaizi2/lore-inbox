Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279499AbRKFTFT>; Tue, 6 Nov 2001 14:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280210AbRKFTFJ>; Tue, 6 Nov 2001 14:05:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280233AbRKFTEy>; Tue, 6 Nov 2001 14:04:54 -0500
Date: Tue, 6 Nov 2001 14:04:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: __FD_SETSIZE question
In-Reply-To: <Pine.LNX.4.30.0111061921580.24965-100000@mustard.heime.net>
Message-ID: <Pine.LNX.3.95.1011106140358.1648A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Roy Sigurd Karlsbakk wrote:

> Hi
> 
> I heard the __FD_SETSIZE setting limits the number of open files to a
> process... Is this the fact? What happens if I double it?
> 
> Thanks
> 
> roy

This just limits the number of fds you can use with select().
Use poll() instead.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


