Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbTC1XlV>; Fri, 28 Mar 2003 18:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263214AbTC1XlV>; Fri, 28 Mar 2003 18:41:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263211AbTC1XlT>;
	Fri, 28 Mar 2003 18:41:19 -0500
Subject: Re: [Lse-tech] Re: [OSDL][BENCHMARK] DBT-2  2.5.65/mjb/osdl
	comparison data
From: Mary Edie Meredith <maryedie@osdl.org>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20030328152516.A22557@beaverton.ibm.com>
References: <1048889724.2535.329.camel@ibm-e.pdx.osdl.net>
	 <20030328152516.A22557@beaverton.ibm.com>
Content-Type: text/plain
Organization: Open Source Development Lab
Message-Id: <1048895544.2532.342.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Mar 2003 15:52:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, I didn't capture read profiles on the non-cached cases.  I will be
collecting readprofile on all cases when I go to 2.5.66, but I didn't on
this round.

If you have a special interest, I can go back and get the data.  It
takes 2hrs per kernel.  If you could identify a subset most interesting
to you, I can do those first.

On Fri, 2003-03-28 at 15:25, Patrick Mansfield wrote:
> On Fri, Mar 28, 2003 at 02:15:24PM -0800, Mary Edie Meredith wrote:
> >                         Score           Score
> > Kernel                  Cached          Non-Cached
> > 2.5.65 base             100 (baseline)  100
> > 2.5.65-mjb2 HZ=100      90.95           99.26
> > 2.5.65-mjb2 HZ=1000     102.38          99.92
> > 2.5.65-osdl1            101.69          99.89
> > 2.5.64-osdl1            104.16          99.67
> > 
> > HZ is defined as 1000 in the base and osdl1 kernels. mjb2 kernel uses
> > Andrew Morton / Dave Hansen patch making HZ a config option of
> > 100 Hz or 1000 Hz).  Also we reversed out the 400-shpte patch.
> > 
> > Link to .config, readprofiles, metric info, raw data:
> > 
> > http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/8way_2_5_65.html
> 
> Do you have readprofiles of the non-cached runs?
> 
> -- Patrick Mansfield
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
-- 
Mary Edie Meredith <maryedie@osdl.org>
Open Source Development Lab

