Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVCaJk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVCaJk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVCaJkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:40:21 -0500
Received: from queuerelay.edis.at ([81.223.48.9]:33664 "EHLO
	queuelrelay.edis.at") by vger.kernel.org with ESMTP id S261241AbVCaJib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:38:31 -0500
Message-ID: <424BC4D5.90204@lawatsch.at>
Date: Thu, 31 Mar 2005 11:37:25 +0200
From: Philip Lawatsch <philip@lawatsch.at>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
References: <3NTHD-8ih-1@gated-at.bofh.it>	<424B7ECD.6040905@shaw.ca>	<200503311025.56871.vda@ilport.com.ua> <20050331001513.3c4321a7.pj@engr.sgi.com>
In-Reply-To: <20050331001513.3c4321a7.pj@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Denis wrote:
> 
>>This reminds me on VIA northbridge problem when BIOS enabled
>>a feature which was experimental and turned out to be buggy.
> 
> 
> You were close!
> 
> I changed my Memory Timing from 1T to 2T, and now it is as solid as a
> rock.  It has been up 7 minutes as I type this, without a hiccup.
> 
> Notice this comment, at http://www.vr-zone.com.sg/?i=1641&p=1&s=0
> 
>     Well as most Athlon 64 users know, 1T setting improves performance quite
>     significantly over 2T, but it is also very taxing on the memory and
>     quite a hit-and-miss when matching different memory with different
>     boards. From some users' feedback, the Asus A8N SLI can be a little
>     picky with 1T setting when overclocking, so results might be a little
>     better with other boards.
> 

I've now tried the most conservative settings available. The 32 bit
kernel now hangs after about 150000 Iterations (compared to about 16000
before) but the 64 bit kernel still hangs after about 5000.

After a ~12 hour memtest86 run memtest86 crashed (!), filling the
console with some garbage characters and then hanging.

This is driving me crazy.

Imo memtest86 should not hang onless something screws up the memory area
it is loaded into.

I've also tried the newest beta bios for the board now, didnt change
anything.

kind regards Philip
