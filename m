Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267591AbSLSBQo>; Wed, 18 Dec 2002 20:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267592AbSLSBQo>; Wed, 18 Dec 2002 20:16:44 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:5592 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S267591AbSLSBQn>; Wed, 18 Dec 2002 20:16:43 -0500
Date: Wed, 18 Dec 2002 17:12:41 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
In-Reply-To: <20021219011541.GI31800@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0212181711200.7848-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also top is very inefficant with large numbers of processes. use vmstat
or cat out the files in /proc to get the info more efficiantly (it won't
get you per process info, but it son't cause the interferance with your
desired load that top gives you.)

David Lang


 On Wed, 18 Dec 2002, William Lee Irwin
III wrote:

> Date: Wed, 18 Dec 2002 17:15:41 -0800
> From: William Lee Irwin III <wli@holomorphy.com>
> To: Till Immanuel Patzschke <tip@inw.de>
> Cc: lse-tech <lse-tech@lists.sourceforge.net>,
>      "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> Subject: Re: 15000+ processes -- poor performance ?!
>
> On Wed, Dec 18, 2002 at 04:53:45PM -0800, Till Immanuel Patzschke wrote:
> > forgot the kernel version (2.4.20aa1)...
>
> 2.4.20aa1 is missing some of the infrastructure to reduce the cpu
> consumption under high process count loads, but that's not going to
> help you anyway. 150K processes is not going to be feasible in the
> immediate future (months or longer away) so you'll have to figure out
> how to take that into account.
>
>
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
