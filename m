Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSIFAPw>; Thu, 5 Sep 2002 20:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSIFAPw>; Thu, 5 Sep 2002 20:15:52 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:22161 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318514AbSIFAPw>; Thu, 5 Sep 2002 20:15:52 -0400
Date: Thu, 5 Sep 2002 21:20:04 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: twoller@crystal.cirrus.com
cc: pcaudio@crystal.cirrus.com, <linux-kernel@vger.kernel.org>
Subject: cs4281 & select in 2.4
Message-ID: <Pine.LNX.4.44L.0209052115280.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it looks like select() is broken for the cs4281 sound driver
in the 2.4 kernel. This breaks pretty much all GUI ham radio
applications that use the sound card ;(

I've done some tracing on various ham radio applications, but
none of the ones that use select() get any data from the cs4281
driver.

The applications tried include glfer and hamfax.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

