Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317785AbSHHTTV>; Thu, 8 Aug 2002 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317906AbSHHTTV>; Thu, 8 Aug 2002 15:19:21 -0400
Received: from holomorphy.com ([66.224.33.161]:47770 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317785AbSHHTTU>;
	Thu, 8 Aug 2002 15:19:20 -0400
Date: Thu, 8 Aug 2002 12:22:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, riel@imladris.surriel.com
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <20020808192201.GF15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@conectiva.com.br>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org, riel@imladris.surriel.com
References: <Pine.LNX.4.44L.0208081149410.2589-100000@duckman.distro.conectiva> <1028836757.28883.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1028836757.28883.73.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 15:51, Rik van Riel wrote:
>> Linux isn't yet up to having 500 simultaneous interactive
>> users, in fact I don't think it has ever been up to this
>> situation.

On Thu, Aug 08, 2002 at 08:59:17PM +0100, Alan Cox wrote:
> It works suprisingly well. I know people who are doing it. It does not
> work when those users are all running arbitarly large jobs. In most
> conventional (non student compile) type setups 500 is fine. The O(1)
> scheduler and highio are pretty essential as is a real I/O subsystem.


Could you put me and/or Rik in contact with them so we can get a better
grip on their issues and  characteristics of their workload?


Thanks,
Bill
