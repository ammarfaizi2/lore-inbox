Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTJNMsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTJNMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:48:30 -0400
Received: from dp.samba.org ([66.70.73.150]:45442 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262369AbTJNMs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:48:29 -0400
Date: Tue, 14 Oct 2003 22:44:57 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031014124457.GB610@krispykreme>
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031014121753.GA610@krispykreme> <20031014053154.469255e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014053154.469255e5.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How big?

Taking a complete guess, 16MB on a 16GB machine wouldnt be missed.

> I guess it should be scaled by ZONE_DMA+ZONE_NORMAL, skipping ZONE_HIGHMEM.

Works for me.

Anton
