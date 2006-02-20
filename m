Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWBTVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWBTVHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWBTVHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:07:33 -0500
Received: from kanga.kvack.org ([66.96.29.28]:29851 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932495AbWBTVHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:07:33 -0500
Date: Mon, 20 Feb 2006 16:02:40 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: linux-kernel@vger.kernel.org
Subject: pc keyboard driver spewing "Unknown key released"
Message-ID: <20060220210240.GA15408@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.16-rc4 on my laptop, I seem to be getting a lot of the following 
spewed onto the console.  It's not reproducible on demand, but seems to be 
related to multi-key press/release sequences when banging away a bit too 
quickly...

		-ben

atkbd.c: Unknown key released (translated set 2, code 0x7f on isa0060/serio0).
atkbd.c: Use 'setkeycodes 7f <keycode>' to make it known.

