Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbTGHGVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 02:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTGHGVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 02:21:05 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:35057 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S264810AbTGHGVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 02:21:03 -0400
Date: Tue, 8 Jul 2003 08:35:27 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Con Kolivas <kernel@kolivas.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Message-ID: <20030708063527.GB13611@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200307070317.11246.kernel@kolivas.org> <1057516609.818.4.camel@teapot.felipe-alfaro.com> <200307071319.57511.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307071319.57511.kernel@kolivas.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas, Mon, Jul 07, 2003 05:19:57 +0200:
> > > Attached is an incremental patch against 2.5.74-mm2 with more
> > > interactivity work. Audio should be quite resistant to skips with this,
> > > and it should not induce further unfairness.
> > >
> > I'm seeing extreme X starvation with this patch under 2.5.74-mm2 when
> > starting a CPU hogger:
> >
> 
> Thanks to Felipe who picked this up I was able to find the one bug causing me 
> grief. The idle detection code was allowing the sleep_avg to get to 
> ridiculously high levels. This is corrected in the following replacement 
> O3int patch. Note this fixes the mozilla issue too. Kick arse!!
> 

still skips. Pan, updating list of newsgroups, VIM compilation and xmms.


