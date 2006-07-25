Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWGYQ6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWGYQ6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWGYQ5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:57:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42891 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932480AbWGYQ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:57:30 -0400
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
From: Arjan van de Ven <arjan@infradead.org>
To: David Lang <dlang@digitalinsight.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
References: <20060725034247.GA5837@kroah.com>
	 <m33bcqdn5y.fsf@anduin.mandriva.com>
	 <200607251123.40549.adq_dvb@lidskialf.net>
	 <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 18:56:58 +0200
Message-Id: <1153846619.8932.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 09:47 -0700, David Lang wrote:
> On Tue, 25 Jul 2006, Andrew de Quincey wrote:
> 
> > On Tuesday 25 July 2006 10:55, Arnaud Patard wrote:
> >> Greg KH <gregkh@suse.de> writes:
> >>
> >> Hi,
> >>
> >>> We (the -stable team) are announcing the release of the 2.6.17.7 kernel.
> >>
> >> Sorry, but doesn't compile if DVB_BUDGET_AV is set :(
> >>
> >>> Andrew de Quincey:
> >>>       v4l/dvb: Fix budget-av frontend detection
> >
> >
> > In fact it is just this patch causing the problem:
> <SNIP>
> > Sorry, I had so much work going on in that area I must have diffed the wrong
> > kernel when I created this patch. :(
> 
> is it reasonable to have an aotomated test figure out what config options are 
> relavent to a patch (or patchset) and test compile all the combinations to catch 
> this sort of mistake?

well you can do such a thing withing statistical bounds; however... if
the patch already is in -git (as is -stable policy normally).. it should
have been found there already...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

