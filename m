Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVK0WKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVK0WKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 17:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK0WKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 17:10:16 -0500
Received: from [139.30.44.16] ([139.30.44.16]:31087 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751163AbVK0WKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 17:10:15 -0500
Date: Sun, 27 Nov 2005 23:07:40 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: user mounting
In-Reply-To: <200511272148.jARLmdn08633@apps.cwi.nl>
Message-ID: <Pine.LNX.4.63.0511272306270.19403@gockel.physik3.uni-rostock.de>
References: <200511272148.jARLmdn08633@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005, Andries.Brouwer@cwi.nl wrote:

> Part of my proposal for a solution lives in kernel space.
> Introduce a mount flag "user mounted". When it is set,
> the kernel will not do a printk() for this filesystem,

Rate limiting seems like a better solution to me.
