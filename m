Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbRBRLZa>; Sun, 18 Feb 2001 06:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132788AbRBRLZV>; Sun, 18 Feb 2001 06:25:21 -0500
Received: from [62.122.97.53] ([62.122.97.53]:64005 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S132757AbRBRLZH>; Sun, 18 Feb 2001 06:25:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: MTU and 2.4.x kernel
In-Reply-To: <200102152041.XAA21220@ms2.inr.ac.ru>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 18 Feb 2001 12:26:09 +0100
In-Reply-To: <200102152041.XAA21220@ms2.inr.ac.ru>
Message-ID: <87u25sb5bi.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



:-> "kuznet" == kuznet  <kuznet@ms2.inr.ac.ru> writes:

    >> Over a radio link where 
    >> error rate causes exponential increases in probability of packet loss as

    > Another myth. All they do error correction and have so high latency,
    > that _increasing_ mtu only helps. And helps a lot.

Please don't break existing implementations. Some old hardware used in
the amateur radio world doesn't even accept an mtu longer than 256(*),
and the resulting packets will be silently chopped at the end. 
If you want to drop mtu lower than 512, please at least add a
CONFIG_I_NEED_A_GODDAMN_SMALL_MTU as an option.

Pf

(*) Kantronics TNCs are an example.




-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
