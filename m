Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTBIVjY>; Sun, 9 Feb 2003 16:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTBIVjY>; Sun, 9 Feb 2003 16:39:24 -0500
Received: from 2-118.ctame702-5.telepar.net.br ([200.140.236.118]:45696 "EHLO
	PolesApart.wox.org") by vger.kernel.org with ESMTP
	id <S267456AbTBIVjX>; Sun, 9 Feb 2003 16:39:23 -0500
Message-ID: <3E46CCD1.60903@PolesApart.dhs.org>
Date: Sun, 09 Feb 2003 19:49:05 -0200
From: Alexandre Pereira Nunes <alex@PolesApart.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.2.1) Gecko/20021130
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: video4linux API question
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


In v4l v1 api, is there a way to get the "active" (current) video input (channel)?
I mean, I can use VIDIOCSCHAN to tell the channel i want, but I can't 
use (i.e.) VIDIOCGCHAN to see what is the selected channel between different programs.
It seems that it could be of some use, since there is already some state stored
in the driver (at least in bttv I can use for example one interactive program for setting
input parameters (bright/contrast/whatever) and then let these settings in effect for another,
non-interactive capture daemon, for example.

Of course there are some implications in doing it this way, but that is exactly my question: if there are some
provisions for something like that (settings remaining throught multiple sessions) planned in th API,
or if I can't rely in this behaviour at all.


Also, are there any provisions for multiple programs open()ing the same device simultaneously?


What about v4l 2, in both issues?


Thanks in advance,


Alexandre



