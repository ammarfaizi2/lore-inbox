Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVBNBQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVBNBQp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 20:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVBNBQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 20:16:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45259 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261325AbVBNBQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 20:16:43 -0500
Date: Sun, 13 Feb 2005 20:16:41 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
Message-ID: <20050214011641.GB29408@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	Philippe Elie <phil.el@wanadoo.fr>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1108274835.3739.2.camel@krustophenia.net> <20050213130058.GA566@zaniah> <20050213133020.GA16363@elte.hu> <1108342535.25912.20.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108342535.25912.20.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 07:55:35PM -0500, Lee Revell wrote:
 > On Sun, 2005-02-13 at 14:30 +0100, Ingo Molnar wrote:
 > > * Philippe Elie <phil.el@wanadoo.fr> wrote:
 > > 
 > > > oprofile_ops.cpu_type == NULL, this has been fixed 3 weeks ago, can
 > > > you retry with -rc4 ?
 > > 
 > > i've uploaded an -rc4 port of the -RT tree half an hour ago (-39-00).
 > > 
 > 
 > OK, I will test that.  FWIW I was running with PREEMPT_DESKTOP.
 > 
 > Maybe my CPU being a Cyrix III (VIA EPIA board) has something to do with
 > it.  I noticed that this CPU model is not mentioned on the oprofile web
 > site.

The C3 doesn't have any performance counters that oprofile can use.

		Dave

