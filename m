Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbSITTn5>; Fri, 20 Sep 2002 15:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263405AbSITTn5>; Fri, 20 Sep 2002 15:43:57 -0400
Received: from [216.40.8.22] ([216.40.8.22]:16072 "EHLO
	postale.optimumdata.com") by vger.kernel.org with ESMTP
	id <S263357AbSITTn4>; Fri, 20 Sep 2002 15:43:56 -0400
Message-ID: <3D8B7BA8.8010403@tux.obix.com>
Date: Fri, 20 Sep 2002 14:48:56 -0500
From: Phil Brutsche <phil@tux.obix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, 2.4.20pre7, problem with aic7xxx driver
References: <20020920052832.GH41965@niksula.cs.hut.fi>	<1184680000.1032536231@aslan.scsiguy.com> <20020920201919.3009507f.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> Hello Justin, hello all,
> 
> I just came across an interesting phenomenon regarding 2.4.19 / 2.4.20-pre7 and
> adaptec scsi. Scene is this:
> 
> board: Asus SP97-V with Pentium 200 (non-MMX) (I know it is old)
> controllers tried: adaptec 29160, 29160N, 2940 U2W
> kernel: 2.4.18-SuSE (distribution 8.0), 2.4.19, 2.4.20-pre7
> 
> From all possible configurations of the above the following work:
> 
> kernel 2.4.18-SuSE: with all controllers
> kernel 2.4.19     : only with 2940 U2W
> kernel 2.4.20-pre7: only with 2040 U2W

The aic7xxx driver works like a champ here in 2.4.17 (vanilla and with 
rmap-11c), vanilla 2.4.19, and early vanilla 2.5.x (last I used was 2.5.9).

This is a 29160 (the 64-bit dual-channel card, not the 19160 or 29160N) 
controller on a MSI 694D-Pro motherboard - dual 1GHz PIIIs.


Phil

