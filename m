Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUJGKcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUJGKcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269780AbUJGKcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:32:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24811 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267381AbUJGKcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:32:46 -0400
Date: Thu, 7 Oct 2004 12:32:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Fraz <fraz@unimail.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Message-ID: <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
References: <41650CAF.1040901@unimail.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41650CAF.1040901@unimail.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I recently upgraded from linux 2.4.27 to 2.6.8.1 and noticed my laptop 
> now makes a high pitch noise while idle. I traced it back to the 
> processor module for acpi. 'rmmod processor' stops the noise. 
> 
> 
> 
> Using speed step to turn it down to 733 Mhz makes it a 
>        little quieter and doesn't change the tone. 
> 
> 
> 
> Is there any way to stop this? I googled around and found it had 
> something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz 
> in the 2.4 kernel. I couldn't find much else on this. Hunting around the 
> code didn't help much, I don't know C. 

Change #define HZ 1000 to #define HZ 100...

Ouch and btw it is hardware problem -- too cheap capacitors.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
