Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263615AbTCUNGt>; Fri, 21 Mar 2003 08:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263616AbTCUNGs>; Fri, 21 Mar 2003 08:06:48 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:36236 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S263615AbTCUNGs>; Fri, 21 Mar 2003 08:06:48 -0500
Date: Fri, 21 Mar 2003 14:17:44 +0100
From: Martin Waitz <tali@admingilde.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
Message-ID: <20030321131744.GL27366@admingilde.org>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3E7A59CD.8040700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7A59CD.8040700@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 04:16:13PM -0800, george anzinger wrote:
> Define CLOCK_MONOTONIC to be the same as
> (gettimeofday() + wall_to_monotonic).

why don't you simply use asm("rdtsc") ?
(ok, you should make sure that you always ask the same processor and
stuff, but using the built in TSC seems to do everything you want...)


-- 
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich 
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit 
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)
