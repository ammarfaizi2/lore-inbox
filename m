Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281006AbRKOTZj>; Thu, 15 Nov 2001 14:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281010AbRKOTZT>; Thu, 15 Nov 2001 14:25:19 -0500
Received: from anime.net ([63.172.78.150]:8969 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S281006AbRKOTZQ>;
	Thu, 15 Nov 2001 14:25:16 -0500
Date: Thu, 15 Nov 2001 11:25:11 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [lm_sensors] wrong sensors readings from w83782d on Tyan Dual
 K7/Thunder
In-Reply-To: <20011115152423.03BD910A3@shrek.lisa.de>
Message-ID: <Pine.LNX.4.30.0111151121560.14296-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2001, Hans-Peter Jansen wrote:
> Readings from temp2 are always lower than from 1 and 3.
> BIOS says:
> temp1 = cpu0
> temp2 = cpu1
> temp3 = chassis

Yes. One cpu is generally right below the power supply so the airflow is
obstructed or something, and it runs warmer than cpu0. Everyone's s2460 is
like this.

temp1:     +41.0 C  (limit =   +2 C, hysteresis =  +64 C) sensor = 3904 transistor
temp2:       +39 C  (limit =  +80 C, hysteresis =  +75 C) sensor = 3904 transistor
temp3:       +42 C  (limit =  +80 C, hysteresis =  +75 C) sensor = 3904 transistor

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

