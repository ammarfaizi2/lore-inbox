Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbUDSNqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUDSNhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:37:13 -0400
Received: from mail.shareable.org ([81.29.64.88]:14500 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264418AbUDSN3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:29:21 -0400
Date: Mon, 19 Apr 2004 14:28:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Johannes Stezenbach <js@convergence.de>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org, "Stephan T. Lavavej" <stl@nuwen.net>
Subject: Re: Process Creation Speed
Message-ID: <20040419132836.GA14341@mail.shareable.org>
References: <200404170219.i3H2JYal007333@localhost.localdomain> <200404182115.20922.eric@cisu.net> <20040419030456.GA11717@mail.shareable.org> <200404190043.04358.eric@cisu.net> <20040419094833.GB13007@mail.shareable.org> <20040419120957.GB3764@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419120957.GB3764@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> > > > None of this answers the question which is relevant to linux-kernel:
> > > > why does process creation take 7.5ms and fail to scale with CPU
> > > > internal clock speed over a factor of 4 (600MHz x86 to 2.2GHz x86).
> 
> http://bulk.fefe.de/scalability/ has some benchmarks on the issue.
> But I guess the numbers depend heavily on the server/CGI software used.

Nice page.  The graphs there show fork() taking 250-350 microseconds,
which is quite fast.  Where is the 7.5ms complaint coming from?

-- Jamie
