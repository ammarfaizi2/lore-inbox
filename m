Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290658AbSAYMaT>; Fri, 25 Jan 2002 07:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290653AbSAYM2N>; Fri, 25 Jan 2002 07:28:13 -0500
Received: from ns.suse.de ([213.95.15.193]:58123 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290651AbSAYM0z>;
	Fri, 25 Jan 2002 07:26:55 -0500
Date: Fri, 25 Jan 2002 13:26:53 +0100
From: Dave Jones <davej@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020125132653.A28068@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rik van Riel <riel@conectiva.com.br>, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020124222357.C901@earthlink.net> <Pine.LNX.4.33L.0201250132450.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201250132450.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Jan 25, 2002 at 01:35:08AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 01:35:08AM -0200, Rik van Riel wrote:

 > Considering the possible bad consequences for real
 > workloads, I'm not sure I want to make the system more
 > unfair just to better accomodate dbench ;)

 it may be useful if Randy can throw a real world test
 into the benchmarking, to get a better comparison of
 the various systems. The obvious one that springs to mind
 would be something like compilation of a large source tree
 kernel/mozilla/etc..  (same version, same config options
 every time). Though, as compilation is largely compute bound,
 instead of IO bound, the more small files that need to be
 read/generated the better.

 Or maybe timing an updatedb. Its realworld enough in that its
 a daily task, generates lots of IO..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
