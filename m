Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbUBPQNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUBPQNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:13:19 -0500
Received: from main.gmane.org ([80.91.224.249]:22706 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265711AbUBPQM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:12:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Subject: Re: Linux 2.6.3-rc3
Date: Mon, 16 Feb 2004 16:58:16 +0100
Organization: Cocytus
Message-ID: <ot57g1-db1.ln1@legolas.mmuehlenhoff.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <m2znbk4s8j.fsf@p4.localdomain> <20040215184449.4db42542.onur@delipenguen.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9507a26.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Onur Kucuk wrote:
>  New radeonfb works better for me, with a bit of trouble, on this Compaq
> EVO N800v.
>
>  The problem is, If I enter X (works fine) and go back to the console,
> there are a few permenant color lines at the bottom. If I do "clear"
> or enter an ncurses based app (like midnight commander) the screen is
> garbled like interlaced.

I can confirm that bug for Radeon 7500 (RV200 QW) as well. The last
line isn't properly cleared.

