Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278815AbRJVODE>; Mon, 22 Oct 2001 10:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278814AbRJVOCy>; Mon, 22 Oct 2001 10:02:54 -0400
Received: from vitelus.com ([64.81.243.207]:6418 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S278815AbRJVOCm>;
	Mon, 22 Oct 2001 10:02:42 -0400
Date: Mon, 22 Oct 2001 07:02:47 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: "peter k." <spam-goes-to-dev-null@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [solved] iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
Message-ID: <20011022070247.A22947@vitelus.com>
In-Reply-To: <004801c153d6$ffc398c0$0100005a@host1> <20011013135507.B9856@vitelus.com> <00ea01c15430$345a96c0$303fe33e@host1> <20011013155259.F9856@vitelus.com> <20011022134558.A746@naboo.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011022134558.A746@naboo.gnumonks.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 01:45:58PM +0200, Harald Welte wrote:
> a) distributor adds dropped-table (from netfilter patch-o-matic) to kernel
> b) distributor builds iptables against this patched kernel
> c) distributor ships this iptables
> d) user installs new, plain kernel
> e) iptables no longer working because it was built against a patched kernel
> f) user has to recompile iptables.

For me it was the other way around. I added dropped-table (for the IRC
nat patch) and had to recompile iptables as a result.
