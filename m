Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUH3A0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUH3A0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 20:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUH3A0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 20:26:20 -0400
Received: from holomorphy.com ([207.189.100.168]:44465 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268372AbUH3A0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 20:26:13 -0400
Date: Sun, 29 Aug 2004 17:26:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040830002604.GB5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <20040829184114.GS5492@holomorphy.com> <20040829192617.GB24937@apps.cwi.nl> <20040829212350.GX5492@holomorphy.com> <20040829232543.GC24937@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829232543.GC24937@apps.cwi.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 01:25:43AM +0200, Andries Brouwer wrote:
> That is good - although so far I have not heard complaints
> about readprofile's memory use. Maybe multiple MB is not
> so excessive these days.
> But improvement is always good.
> On the other hand, I like stability. Maybe readprofile is just some
> kind of throwaway utility, not very important, but nevertheless,
> some people use it, and they have habits and hate to relearn,
> and they have scripts, and hate to adapt these scripts.
> So, if the internal code is improved, excellent, but I am not so
> happy if the invocation is changed without a very good reason.
> Maybe you can make a cross: your improved algorithm inside the
> old framework with options and locale?

Easy enough, though I suppose there are also stylistic improvements.


On Sun, Aug 29, 2004 at 02:23:50PM -0700, William Lee Irwin III wrote:
>> The removal of -V was intentional, as I consider it bloat.

On Mon, Aug 30, 2004 at 01:25:43AM +0200, Andries Brouwer wrote:
> Don't you know that whenever there are complaints about software
> the very first question is "which version?"?

Okay, I suppose asking to look at external information with dpkg, rpm,
etc. may not be feasible/desirable under all circumstances.


On Sun, Aug 29, 2004 at 02:23:50PM -0700, William Lee Irwin III wrote:
>> I wasn't really expecting much to come of it besides prodding people
>> to clean up bloat. The reduced functionality alone likely precludes it
>> from consideration for inclusion. Supposing that there is greater
>> interest, which I don't expect, I can fix these things up and so on.

On Mon, Aug 30, 2004 at 01:25:43AM +0200, Andries Brouwer wrote:
> Well, you sent me something. I have three choices: take it as
> replacement for the current version, ignore it, work on it.
> I have no time to work on it, so am only happy with what you send
> if it can replace the current version.

I'll look around to see how much interest there is, or if others
complain about the issues I'm concerned with, or others find them
sufficiently compelling, and send an update for inclusion of the
form that appears to be preferred if so.


-- wli
