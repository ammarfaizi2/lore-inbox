Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUDFMRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUDFMRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:17:18 -0400
Received: from levante.wiggy.net ([195.85.225.139]:54705 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S263752AbUDFMRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:17:03 -0400
Date: Tue, 6 Apr 2004 14:17:01 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: {put,get}_user() side effects
Message-ID: <20040406121701.GG3611@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1HVGV-1Wl-21@gated-at.bofh.it> <m3fzbhfijh.fsf@averell.firstfloor.org> <1081252228.8318.1.camel@speedy.priv.grenoble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081252228.8318.1.camel@speedy.priv.grenoble.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Xavier Bestel wrote:
> Using ptr three times in a define has side effects if ptr is an
> expression with side effects (e.g. "p++").

As I understand it both typeof and sizeof don't evalutate their argument
but only look at its type. Which means using p++ is perfectly safe.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

