Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbTCYOkk>; Tue, 25 Mar 2003 09:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbTCYOkk>; Tue, 25 Mar 2003 09:40:40 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:15281 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S262672AbTCYOkj>; Tue, 25 Mar 2003 09:40:39 -0500
From: Erik Hensema <usenet@hensema.net>
Subject: Negative dynamic priorities in 2.5.6[4-6]?
Date: Tue, 25 Mar 2003 14:51:48 +0000 (UTC)
Message-ID: <slrnb80r80.288.usenet@bender.home.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since upgrading to 2.5.64 from 2.4.x, I'm seeing negative dynamic
priorities in top. top from procps-2.0.11 treats PRI as an unsigned long
long, so it displays negative priorities as being extremely large.
After changing the format specifier, top displays -51 for artsd:

  PID USER     PRI  NI  SIZE SWAP  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1136 erik     -51   0 11040 4592 6448  8828 S     1.5  1.2   0:36 artsd

kernel 2.5.66 vanilla
procps 2.0.11
arts 1.1-50 packaged for suse 8.0

this is while playing a shoutcast mp3 stream.

Is this normal behaviour?
-- 
Erik Hensema <erik@hensema.net>
