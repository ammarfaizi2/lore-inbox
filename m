Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUI3HzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUI3HzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUI3HzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:55:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:29319 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S268767AbUI3HzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:55:08 -0400
Date: Thu, 30 Sep 2004 09:55:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] Psmouse - add packet size
Message-ID: <20040930075537.GB4910@ucw.cz>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290824.59004.dtor_core@ameritech.net> <20040929133859.GA3896@ucw.cz> <200409300143.23582.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409300143.23582.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 01:43:23AM -0500, Dmitry Torokhov wrote:

> On Wednesday 29 September 2004 08:38 am, Vojtech Pavlik wrote:
> > Well, I understand your point, but I still think it's worth keeping the
> > return values consistent with the rest of the probe routines, because if
> > not, THEN you (or some other reader) would get used to the
> > positive-style returns with the protocol detection routines and
> > definitely understand it wrong elsewhere.
> > 
> 
> Vojtech,
> 
> I converted the -detect routines to return -1 on failure and implemented the
> other change you have requested. Please do:
> 
> 	bk pull bk://dtor.bkbits.net/input
 
Done, thanks!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
