Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUB0Qg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbUB0Qg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:36:28 -0500
Received: from holomorphy.com ([199.26.172.102]:36100 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263042AbUB0Qfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:35:55 -0500
Date: Fri, 27 Feb 2004 08:35:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040227163546.GB655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zlatko Calusic <zlatko.calusic@iskon.hr>,
	Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net> <20040226163236.M22989@build.pdx.osdl.net> <403E958B.6020406@roemling.net> <20040227011151.GT693@holomorphy.com> <403E9E54.6030404@roemling.net> <dnad34xz2p.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dnad34xz2p.fsf@magla.zg.iskon.hr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 05:32:46PM +0100, Zlatko Calusic wrote:
> Of course! Appended simple patch is what i did (ugly, I know) and that
> helped me install Oracle10g on Debian unstable (with two other
> adaptations). I don't know how in the hell I forgot to put that
> important patch on my page where I explain how to install Oracle10g on
> Debian?! Sorry, it'll be on http://linux.inet.hr/oracle10g_on_debian.html
> later today or tomorrow, after I check some other problems people have
> reported to me (and you Jochen, too :)).

You have to be a bit more careful than this; this gives any user the
ability to consume locked memory via shmget().


-- wli
