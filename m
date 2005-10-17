Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVJQMrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVJQMrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVJQMrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:47:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:64203 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932298AbVJQMru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:47:50 -0400
Date: Mon, 17 Oct 2005 14:48:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tsc_c3_compensate undefined since patch-2.6.13-rt13
Message-ID: <20051017124820.GA17154@elte.hu>
References: <20050901072430.GA6213@elte.hu> <1125571335.15768.21.camel@localhost.localdomain> <20051003065032.GA23777@elte.hu> <43424B7C.9020508@rncbc.org> <20051004101434.GA26882@elte.hu> <4352D79D.9070901@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4352D79D.9070901@rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> As it seems, tsc_c3_compensate isn't being defined again, as of 
> patch-2.6.14-rc4-rt6 (-rt4 was ok).

oops - export went MIA during the clockevents merge. Have put it back 
again. (will be in -rt7)

	Ingo
