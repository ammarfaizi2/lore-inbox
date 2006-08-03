Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWHCCeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWHCCeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 22:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWHCCeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 22:34:17 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:57988
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750743AbWHCCeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 22:34:16 -0400
Date: Wed, 2 Aug 2006 19:34:01 -0700
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.17-rt8 crash amd64
Message-ID: <20060803023401.GA3767@gnuppy.monkey.org>
References: <20060802011809.GA26313@gnuppy.monkey.org> <5bdc1c8b0608021820u5235c491tdf9b25f5906fe3f8@mail.gmail.com> <20060803014154.GA3370@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803014154.GA3370@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 06:41:54PM -0700, Bill Huey wrote:
> On Wed, Aug 02, 2006 at 06:20:50PM -0700, Mark Knecht wrote:
> >   Anyway, not a one machine problem at all.
> 
> Any stack trace is welcomed.
> 
> I just changed a couple of things to get a better stack trace and it's
> changed the timing of the system where I can't get a reliable stack
> trace anymore. Try another route...

Steve and company,

Talking about problems. I'm getting "1491240 >"  calls to task_blocks_on_rt_mutex()
on boot up. This sounds ridiculously high and it makes me wonder what's going
on with the kernel from a macro level (ignoring the exact places for now).

bill

