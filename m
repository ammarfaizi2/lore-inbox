Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318809AbSG0Thw>; Sat, 27 Jul 2002 15:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSG0Thw>; Sat, 27 Jul 2002 15:37:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:14583 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318809AbSG0Thw>; Sat, 27 Jul 2002 15:37:52 -0400
Date: Sat, 27 Jul 2002 21:41:03 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: kees <kees@schoen.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19.rc3 vs 2.4.17
In-Reply-To: <Pine.LNX.4.33.0207272012340.1731-100000@schoen3.schoen.nl>
Message-ID: <Pine.NEB.4.44.0207272130340.9592-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, kees wrote:

> Hi
> I ran 2.4.19rc3 but my feeling is: Netscape 6.2 and (KDE3) Konqueror
> showed a high number of spontaneous crashes. 256MB Ram xosview shows a few
>...

You say Netscape and Konqueror crash significantely more often when
running 2.4.19-rc3 compared to running the same applications under 2.4.17?

Let's try to track it down:
- Do only Netscape/Konqueror crash or does X crash or does the whole
  computer crash?
- Is there any error message when the browsers crash, if yes which?
- Are there any suspicious messages in /var/log/syslog or
  /var/log/messages that might help in tracking this down?
- Is your 2.4.17 a plain ftp.kernel.org kernel or a kernel shipped by your
  distribution?
- Do you apply any patches to your kernels?
- Do you ever load non-free kernel modules like e.g. the one from NVidia?
  If yes, are your problems reproducible if no non-free modules were
  _ever_ loaded since the last reboot?
- Is there anything "special" or unusual with your machine (is it a
  laptop, root filesystem is on NFS or XFS, unusual hardware,...)?

> Kees

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


