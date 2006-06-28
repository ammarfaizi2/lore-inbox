Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWF1AFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWF1AFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWF1AFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:05:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16342 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750837AbWF1AFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:05:52 -0400
Date: Tue, 27 Jun 2006 17:06:27 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com, oleg@tv-sign.ru
Subject: Re: [PATCH 0/2] srcu-2: add RCU variant that permits read-side blocking
Message-ID: <20060628000627.GA1288@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627233702.GA2696@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627233702.GA2696@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 04:37:02PM -0700, Paul E. McKenney wrote:
> Updated based on review comments from Andrew and Oleg (thank you!).
> 
> Oleg's bug did turn out to be real (thank you, Oleg!!!), so this patch
> contains an alleged fix.  It passes a short rcutorture run on x86 and
> ppc64, but so did the previous one (more intense testing in the offing).
> This patchset depends on the earlier ops-ization of the rcutorture
> infrastructure.

Oh, and it passed on s390 as well.

							Thanx, Paul
