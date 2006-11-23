Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933278AbWKWIw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbWKWIw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933284AbWKWIw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:52:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:21646 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933278AbWKWIw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:52:58 -0500
Date: Thu, 23 Nov 2006 09:52:54 +0100
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       eranian@hpl.hp.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
Message-ID: <20061123085254.GA29738@bingen.suse.de>
References: <200611180924.01979.ak@suse.de> <6428.1164261827@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6428.1164261827@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> LBR is mainly useful on wild branches to random addresses.  As such,

The page fault handler is one of the most performance critical 
exceptions.  And then on x86-64 a lot of stray pointers actually result in a 
#GP, not a page fault.

-Andi
