Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUFXPXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUFXPXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUFXPXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:23:16 -0400
Received: from holomorphy.com ([207.189.100.168]:24458 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265510AbUFXPXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:23:05 -0400
Date: Thu, 24 Jun 2004 08:23:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624152301.GC21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com> <20040624141637.GA20702@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624141637.GA20702@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 11:16:37AM -0300, Marcelo Tosatti wrote:
> Removing the check on v2.4 based kernels will trigger the OOM killer
> too soon for a lot of cases, I'm pretty sure.

Other 2.4 oom_kill.c issues aside, since this is a relatively blatant
deadlock. What form would you like a fix to take, if you care to have
a fix for this at all?


-- wli
