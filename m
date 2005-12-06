Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVLFOcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVLFOcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVLFOcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:32:06 -0500
Received: from mail.enyo.de ([212.9.189.167]:41673 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932592AbVLFOcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:32:05 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	<20051203201945.GA4182@kroah.com>
	<9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com>
	<20051204115650.GA15577@merlin.emma.line.org>
	<20051204232454.GG8914@kroah.com>
Date: Tue, 06 Dec 2005 15:32:02 +0100
In-Reply-To: <20051204232454.GG8914@kroah.com> (Greg KH's message of "Sun, 4
	Dec 2005 15:24:54 -0800")
Message-ID: <87psoapa8t.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH:

> What are we breaking that people are complaining so much about?
> Specifics please.

Drastic performance changes in certain pipe usage patterns.  This was
probably too early in the 2.6 series to count, though.

There might be some subtle changes in the netfilter/routing
interaction which break user configurations, but this still being
tracked down (and maybe the any behavior is fine because it's
unspecified; hard to tell).
