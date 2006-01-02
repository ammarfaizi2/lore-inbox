Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWABPgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWABPgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 10:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWABPgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 10:36:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5882 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750754AbWABPgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 10:36:53 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323310@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323310@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 07:36:51 -0800
Message-Id: <1136216211.22548.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 15:55 +0100, kus Kusche Klaus wrote:
> > From: Daniel Walker
> > Right .. I'm still looking into it. ARM is just missing some vital
> > tracing bits I think .
> 
> As I wrote in some earlier mail, I'm probably the first one ever
> who tried it on ARM: When I tried first, tracing didn't work at all,
> because the trace timing macro's were not defined (at least for
> sa1100). I quick-hacked the three missing macros (this caused the
> tracer to produce at least some output) without checking if 
> anything else is missing.

I'm sure the code has been tested , but I doubt it's ever really been
used .

What macro's are you talking about? Did you submit a patch already to
fix that? If not, please do.

Daniel

