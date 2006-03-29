Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWC2RCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWC2RCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWC2RCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:02:12 -0500
Received: from nsm.pl ([195.34.211.229]:46858 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1750853AbWC2RCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:02:11 -0500
Date: Wed, 29 Mar 2006 19:01:22 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Cc: Romano Giannetti <romanol@upcomillas.es>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
Message-ID: <20060329170122.GA4090@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Romano Giannetti <romanol@upcomillas.es>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@atrey.karlin.mff.cuni.cz
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es> <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com> <20060327190826.GA18193@pern.dea.icai.upcomillas.es> <d120d5000603271112r35ba7100jceb8aaf3e8bf8c70@mail.gmail.com> <20060329164330.GA8977@pern.dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329164330.GA8977@pern.dea.icai.upcomillas.es>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 06:43:30PM +0200, Romano Giannetti wrote:
> 
> On Mon, Mar 27, 2006 at 02:12:26PM -0500, Dmitry Torokhov wrote:
> > On 3/27/06, Romano Giannetti <romanol@upcomillas.es> wrote:
> > >
> > > Udev is 054 (as per Mandriva 2005). Is that the culprit?
> > 
> > [~/linux] grep udev Documentation/Changes
> > o  udev                   071                     # udevinfo -V
> > ...
> 
> Bad news... I tried to upgrade udev to 088, but evidently this is not a
> trivial task.

  It's not so easy.  You have to carefully read release notes for every
udev release between 054 and 088, and spot every incompatibile change.
And accommodate.

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray

