Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277214AbRJDTNO>; Thu, 4 Oct 2001 15:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277211AbRJDTNE>; Thu, 4 Oct 2001 15:13:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20982 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S277212AbRJDTMw>; Thu, 4 Oct 2001 15:12:52 -0400
Message-ID: <3BBCB41A.B7C66E03@mvista.com>
Date: Thu, 04 Oct 2001 12:10:18 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Christian Schroeder <c-h.schroeder@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Problems with Kernel 2.4.10 on SMP
In-Reply-To: <20011003145729Z276343-760+20191@vger.kernel.org> <20011003220850.H3638@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Wed, Oct 03, 2001 at 04:56:51PM +0200, Christian Schroeder wrote:
> > since I've been experisnsing large problems with my linux box crashing and
> > crashing again, I want to give you this bug report, maybe someone else has
> > the same problem. I used the bug report format in explained in the kernel
> > sources.
> 
> [...]
> 
> > [7.3]
> > snd-pcm-oss            18816   1 (autoclean)
> > snd-pcm-plugin         14256   0 (autoclean) [snd-pcm-oss]
> > snd-mixer-oss           5280   0 (autoclean) [snd-pcm-oss]
> > NVdriver              723872  14 (autoclean)
>   ^^^^^^^^
> You have the NVidia binary only module loaded on your system. Either
> get support from NVidia, or try to recreate the bug without this
> module.
> 
> Erik
> 
Also, turn on the NMI watchdog!  See Documentation
.../Documentation/nmi_watchdog.txt in your kernel tree.

George
