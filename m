Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267175AbUFZPaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUFZPaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267178AbUFZPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 11:30:22 -0400
Received: from havoc.gtf.org ([216.162.42.101]:49820 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267175AbUFZPaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 11:30:21 -0400
Date: Sat, 26 Jun 2004 11:30:18 -0400
From: David Eger <eger@havoc.gtf.org>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb == blank screen (Thinkpad r50p - FireGL T2 1600x1200 LCD)
Message-ID: <20040626153018.GA17639@havoc.gtf.org>
References: <20040618154118.ED0D5106@damned.travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618154118.ED0D5106@damned.travellingkiwi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't look like you have fbcon enabled... make sure you have
at least the following set in your .config:

CONFIG_FB=y
CONFIG_FB_RADEON=y
CONFIG_FRAMEBUFFER_CONSOLE=y

-dte
