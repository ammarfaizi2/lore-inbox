Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSKBOsO>; Sat, 2 Nov 2002 09:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSKBOsO>; Sat, 2 Nov 2002 09:48:14 -0500
Received: from ns.ithnet.com ([217.64.64.10]:24844 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261224AbSKBOsN>;
	Sat, 2 Nov 2002 09:48:13 -0500
Date: Sat, 2 Nov 2002 15:54:31 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM REPORT 2.4.20-rc1: sundance.c
Message-Id: <20021102155431.7a01ed55.skraw@ithnet.com>
In-Reply-To: <3DC19ACA.9030906@pobox.com>
References: <20021031173834.4514603a.skraw@ithnet.com>
	<3DC19ACA.9030906@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002 16:04:10 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Stephan von Krawczynski wrote:
> 
> >Hello all,
> >
> >I'd like to point out that (at least) the network driver sundance.c has
> >weird flaws when trying to use more than MAX_UNITS (8) cards at the same
> >time. Since
> >
> 
> Smileys nonwithstanding, you need to include far more information
> 
> Please define "weird flaws"... explicitly.

I am experiencing dropped packets as sundance RX side when simple nfs copying
takes places. These are at a rate of about 1-2% of RX packets. I call it
"weird" because I cannot see a definitive problem location in the driver
source. fact stays one simple copy drops packets, something I never saw in the
same setup (same cabling, same mainboard) with tulip cards.
I know that this is a hell of a "bug-report", but I really want to point out
only a strange difference between tulip-setup and sundance-setup.
-- 
Regards,
Stephan
