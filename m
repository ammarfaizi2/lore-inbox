Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUHBVyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUHBVyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHBVyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:54:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42727 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264002AbUHBVxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:53:17 -0400
Date: Mon, 2 Aug 2004 17:52:31 -0400
From: Alan Cox <alan@redhat.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Initial bits to help pull jiffies out of drivers
Message-ID: <20040802215231.GA8586@devserv.devel.redhat.com>
References: <20040727195939.GA20712@devserv.devel.redhat.com> <410EB30F.3060001@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410EB30F.3060001@am.sony.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 02:33:03PM -0700, Tim Bird wrote:
> Alternatively, I could cook up a macro using sched_clock() to provide
> a substitute value to use to print timing info, in cases where it
> was desirable to preserve it.

We are certainly going to need a "time_now()" type function in some places
I agree.

