Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWHBT7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWHBT7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHBT7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:59:13 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:48576
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932209AbWHBT65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:58:57 -0400
Date: Wed, 2 Aug 2006 12:58:31 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.17-rt8 crash amd64
Message-ID: <20060802195831.GA787@gnuppy.monkey.org>
References: <20060802011809.GA26313@gnuppy.monkey.org> <1154482302.30391.14.camel@localhost.localdomain> <20060802021956.GC26364@gnuppy.monkey.org> <20060802022539.GA26799@gnuppy.monkey.org> <20060802071348.GA28653@gnuppy.monkey.org> <1154539004.8620.16.camel@c-67-188-28-158.hsd1.ca.comcast.net> <20060802173553.GA29327@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802173553.GA29327@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 10:35:53AM -0700, Bill Huey wrote:
> On Wed, Aug 02, 2006 at 10:16:44AM -0700, Daniel Walker wrote:
> > Are you using a 32-bit userspace and a 64-bit kernel ?
> 
> Yes, but this happens with 64 bit apps as well. I'm going to take a
> deeper look at it today. My current track is to look at processes
> reaping. That seems to be a common attribute in all of those stack
> traces. I thought there was more debug instrumentation that dealt
> with preempt_count tracking before ?

I could also be dead wrong about this and folks with more intimate
knowledge of the relevant kernel bits could beat me to this bug fix
(and are welcomed to).

bill

