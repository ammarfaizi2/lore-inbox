Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTF0W51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTF0W51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:57:27 -0400
Received: from dialup-168.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.168]:10500
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264887AbTF0W50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:57:26 -0400
Message-ID: <3EFCCF23.4050009@cyberone.com.au>
Date: Sat, 28 Jun 2003 09:11:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] O1int patch with contest
References: <200306280041.47619.kernel@kolivas.org>
In-Reply-To: <200306280041.47619.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>I've had some (off list) requests to see if the interactivity patch I posted 
>shows any differences in contest. To be honest I wasn't sure it would, and 
>this is not quite what I expected. Below is a 2.5.73-mm1 patched with 
>patch-O1int-0306271816 (2.5.73-O1i) compared to 2.5.73-mm1 with contest 
>(http://contest.kolivas.org).
>  
>

Hi Con,
It looks like the patch is starving the background loads.
read_load for example can use up to 7% (maybe more) of the
CPU. It is brought down to 2.2%, list_load is worse.


