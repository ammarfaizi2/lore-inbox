Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263198AbTC1XR6>; Fri, 28 Mar 2003 18:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263200AbTC1XR6>; Fri, 28 Mar 2003 18:17:58 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:17378 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263198AbTC1XR5>; Fri, 28 Mar 2003 18:17:57 -0500
Date: Fri, 28 Mar 2003 15:25:16 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Mary Edie Meredith <maryedie@osdl.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [OSDL][BENCHMARK] DBT-2  2.5.65/mjb/osdl comparison data
Message-ID: <20030328152516.A22557@beaverton.ibm.com>
References: <1048889724.2535.329.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1048889724.2535.329.camel@ibm-e.pdx.osdl.net>; from maryedie@osdl.org on Fri, Mar 28, 2003 at 02:15:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 02:15:24PM -0800, Mary Edie Meredith wrote:
>                         Score           Score
> Kernel                  Cached          Non-Cached
> 2.5.65 base             100 (baseline)  100
> 2.5.65-mjb2 HZ=100      90.95           99.26
> 2.5.65-mjb2 HZ=1000     102.38          99.92
> 2.5.65-osdl1            101.69          99.89
> 2.5.64-osdl1            104.16          99.67
> 
> HZ is defined as 1000 in the base and osdl1 kernels. mjb2 kernel uses
> Andrew Morton / Dave Hansen patch making HZ a config option of
> 100 Hz or 1000 Hz).  Also we reversed out the 400-shpte patch.
> 
> Link to .config, readprofiles, metric info, raw data:
> 
> http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/8way_2_5_65.html

Do you have readprofiles of the non-cached runs?

-- Patrick Mansfield
