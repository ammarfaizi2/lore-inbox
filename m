Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTLTTc4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 14:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbTLTTc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 14:32:56 -0500
Received: from p15108950.pureserver.info ([217.160.128.7]:31639 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id S263879AbTLTTcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 14:32:55 -0500
Date: Sat, 20 Dec 2003 20:34:02 +0100
From: Marc Schiffbauer <marc@schiffbauer.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Message-ID: <20031220193402.GA32297@lisa>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1071864709.1044.172.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071864709.1044.172.camel@localhost>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.20-hpt i686
X-Editor: vim 6.1.018-1
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Meder schrieb am 19.12.03 um 21:11 Uhr:
> Hi,
> 
> I've got a longstanding regression in gnomemeeting usage when switching
> between 2.4 and 2.6 kernels.
> 
> Phenomenon: 
> Without load gnomemeeting VOIP connections are fine. As soon as some
> load like a kernel compile is put on the laptop the gnomemeeting audio
> stream is cut to pieces and gets unintelligible . On 2.4.2x I don't get
> even the slightest distortion in the audio stream under load. I played
> around with different nice levels with no success. The problem persisted
> during the whole 2.6.0-test series no matter whether I used -mm kernels
> or pristine Linus kernels. Even when nicing the kernel compile to +19
> the distortions start right away. I tried Nick Piggin's scheduler which
> fared slightly better after changing the nice level of gnomemeeting to
> -10 but it's still a far cry from the 2.4.2x feeling without any
> fiddling with nice values.
> 
> Any hints where to start looking are greatly appreciated.
> 

Hi Christian,

is it true, that your X-Server runs with a higher priority? Perhaps
you are a Debian user?

If thats the case try to make your X-Server run with normal
priority. That fixed sound problems here too. I had the problem that
I could not play an mp3 file without distortion while compiling a
kernel.

-Marc
-- 
8AAC 5F46 83B4 DB70 8317  3723 296C 6CCA 35A6 4134
