Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268302AbUHKXJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268302AbUHKXJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUHKXHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:07:52 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:18137 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S268302AbUHKXET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:04:19 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: 2.6.8-rc3-np1
Date: Wed, 11 Aug 2004 16:04:29 -0700
User-Agent: KMail/1.7
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <4117494E.704@yahoo.com.au> <1092262435.8976.59.camel@nosferatu.lan>
In-Reply-To: <1092262435.8976.59.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408111604.30739.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applied fine here with some tweaking. Removing the nmi fixes from the np 
patch allowed it to apply just fine with some offsets , but not fuzz.

Matt



On Wednesday 11 August 2004 3:13 pm, Martin Schlemmer wrote:
> On Mon, 2004-08-09 at 11:52, Nick Piggin wrote:
> > http://www.kerneltrap.org/~npiggin/2.6.8-rc3-np1/
> >
> > Patch is against 2.6.8-rc3-mm2 only at this stage due to significant
> > memory management changes in there making it difficult to track Linus'
> > tree as well.
> >
> > Feedback on the scheduler would be much appreciated, as it might get
> > a run in Andrew's tree soon.
>
> I am trying to get it patched against rc4-mm1, but it seems there
> are some issues with the SMT bits - dependent_sleeper for example
> is still around although it was removed with all previous patches
> (and uses task_t.time_slice which is no longer there).
>
> I assume you forgot to apply them?  Possible to get a complete
> patch?  If not, I'll see if I can get something going after some
> sleep.
>
>
> Thanks,
