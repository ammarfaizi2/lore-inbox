Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUFXR2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUFXR2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266722AbUFXR2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:28:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266721AbUFXR2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:28:10 -0400
Date: Thu, 24 Jun 2004 13:55:41 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624165541.GA21496@logos.cnet>
References: <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com> <20040624141637.GA20702@logos.cnet> <20040624152301.GC21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624152301.GC21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:23:01AM -0700, William Lee Irwin III wrote:
> On Thu, Jun 24, 2004 at 11:16:37AM -0300, Marcelo Tosatti wrote:
> > Removing the check on v2.4 based kernels will trigger the OOM killer
> > too soon for a lot of cases, I'm pretty sure.
> 
> Other 2.4 oom_kill.c issues aside, since this is a relatively blatant
> deadlock. What form would you like a fix to take, if you care to have
> a fix for this at all?

Lets hold this on 2.4.28-pre1, as discussed privately.

Thanks again.
