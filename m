Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261655AbSIXLpW>; Tue, 24 Sep 2002 07:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261656AbSIXLpW>; Tue, 24 Sep 2002 07:45:22 -0400
Received: from holomorphy.com ([66.224.33.161]:13978 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261655AbSIXLpV>;
	Tue, 24 Sep 2002 07:45:21 -0400
Date: Tue, 24 Sep 2002 04:50:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 32bit wraps and USER_HZ [64 bit counters], kernel 2.5.37
Message-ID: <20020924115025.GD3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Rolf Fokkens <fokkensr@fokkensr.vertis.nl>,
	linux-kernel@vger.kernel.org
References: <200209232208.g8NM8bN05831@fokkensr.vertis.nl> <Pine.LNX.4.33.0209241342470.4261-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209241342470.4261-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Rolf Fokkens wrote:
>> Since nobody else asks this question:
>> Do you mean to leave out process statistics?

On Tue, Sep 24, 2002 at 01:47:38PM +0200, Tim Schmielau wrote:
> We don't need to leave out process statistics completely, but per-CPU 
> per-process statistics indeed looks like overkill.
> Tim
> P.S.: Some work with respect to cleaning up interfaces of 32 bit jiffies 
> has gone into -dj already, but I'm still waiting for the next -dj release 
> to sync up.


The per-cpu per-process stats are the only ones I suggest removing.
NR_CPUS can get large enough to cause a significant amount of bloat.


Cheers,
Bill
