Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267830AbUH3M3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267830AbUH3M3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267834AbUH3M3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:29:15 -0400
Received: from holomorphy.com ([207.189.100.168]:41140 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267830AbUH3M3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:29:10 -0400
Date: Mon, 30 Aug 2004 05:28:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040830122854.GF5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paulo Marques <pmarques@grupopie.com>,
	Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube> <4133020F.1060306@grupopie.com> <20040830105322.GE5492@holomorphy.com> <41331C57.3070304@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41331C57.3070304@grupopie.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> This seems to go wrong on big-endian machines; any chance you could look
>> over your stuff and try to figure out what endianness issues it may have?

On Mon, Aug 30, 2004 at 01:23:51PM +0100, Paulo Marques wrote:
> I went over the code but at a first glance couldn't find a notorius 
> trouble spot. I don't have big-endian hardware myself so this is hard to 
> test.
> Just a few questions to help me out in finding the problem:
> - is this really an endianess problem or is it a 64-bit integer problem?

Works fine on x86-64 and alpha. Prints gibberish on sparc64.


On Mon, Aug 30, 2004 at 01:23:51PM +0100, Paulo Marques wrote:
> - are you cross compiling the kernel?
> Thanks in advance,

No. All native.


-- wli
