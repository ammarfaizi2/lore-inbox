Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRF0Oo7>; Wed, 27 Jun 2001 10:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbRF0Oou>; Wed, 27 Jun 2001 10:44:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17938 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262609AbRF0Ooh>; Wed, 27 Jun 2001 10:44:37 -0400
Date: Wed, 27 Jun 2001 10:11:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
Cc: linux-kernel@vger.kernel.org,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
In-Reply-To: <3B39ED60.102370B3@baldauf.org>
Message-ID: <Pine.LNX.4.21.0106271010530.1331-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Xuan Baldauf wrote:

> Hello,
> 
> I'm not sure wether this is a reiserfs bug or a kernel bug,
> so I'm posting to both lists...
> 
> My linux box suddenly was not availbale using ssh|telnet,
> but it responded to pings. On console login, I could type
> "root", but after pressing "return", there was no reaction,
> and pressing keys did not result in writing them on the
> screen.
> 
> "Emergency sync" and "Remount R/O" did not have any
> response.
> 
> That's why I pressed Alt+SysRq+P 5 times and wrote all stack
> traces (without registers) onto paper. After that, I pressed
> Alt+SysRq+T and also wrote 3 long stack traces (others were
> available too, but too short) down.

Xuan, 

Are you using kiobuf IO ?

