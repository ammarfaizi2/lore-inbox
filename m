Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTBGUKC>; Fri, 7 Feb 2003 15:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTBGUKC>; Fri, 7 Feb 2003 15:10:02 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:25099 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266368AbTBGUKB>; Fri, 7 Feb 2003 15:10:01 -0500
Date: Fri, 7 Feb 2003 21:19:10 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 won't boot, 2.5.58 will, how to I use bitkeeper to get 'in between' ?
Message-ID: <20030207201910.GA4322@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030206060742.GA6458@middle.of.nowhere> <20030206123340.GA3305@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206123340.GA3305@codemonkey.org.uk>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@codemonkey.org.uk>
Date: Thu, Feb 06, 2003 at 12:33:40PM +0000
> On Thu, Feb 06, 2003 at 07:07:42AM +0100, Jurriaan wrote:
>  > Until now, all 2.5.59-based kernels (2.5.59 vanilla, 2.5.59 + vmlinux
>  > patch, 2.5.59-mm[1-8]) hang very early in the boot-process on my system,
>  > right after 'Uncompressing Linux...'
> 
> Two suspects (from freezing boxes Ive had here) are ACPI and PNP. Try
> disabling those first.
> 
I didn't use them. I was busy checking out where between cset-943 and
cset-944 it stopped booting, when I accidentally removed my .config
file. I recreated it from the one I posted earlier to lkml, and suddenly
all 2.5.59 kernels boot. I don't know if I'm glad it's solved or
irritated that I don't know how it was solved.

Anyway, 2.5.59-mm8 boots here just fine.

Thanks everyone!

Jurriaan
-- 
Gore of Borg: I invented the collective!
GNU/Linux 2.5.59 SMP/ReiserFS 2x2318 bogomips load av: 0.05 0.06 0.02
