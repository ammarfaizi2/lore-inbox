Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVECCgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVECCgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 22:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVECCgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 22:36:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:14269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261304AbVECCfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 22:35:55 -0400
Date: Mon, 2 May 2005 19:35:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-Id: <20050502193503.20e6ac6e.rddunlap@osdl.org>
In-Reply-To: <20050503012951.GA10459@animx.eu.org>
References: <20050503012951.GA10459@animx.eu.org>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005 21:29:51 -0400 Wakko Warner wrote:

| Is it possible to use zImage on 2.6 kernels or is bzImage required?

What processor architecture?

It's supported in arch/i386/Makefile (and some others).
For i386, you'll need to disable enough (lots of) options to make the
resulting output file small enough...

---
~Randy
