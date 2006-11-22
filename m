Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161807AbWKVCai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161807AbWKVCai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161825AbWKVCai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:30:38 -0500
Received: from iabervon.org ([66.92.72.58]:45586 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1161807AbWKVCah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:30:37 -0500
Date: Tue, 21 Nov 2006 21:30:36 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18.2: Nobody cared about the millionth sata_nv interrupt
In-Reply-To: <Pine.LNX.4.64.0611211603270.20138@iabervon.org>
Message-ID: <Pine.LNX.4.64.0611212129310.20138@iabervon.org>
References: <Pine.LNX.4.64.0611211603270.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed this with the patch I sent a moment ago; ethernet card was sending 
INTx interrupts while sending MSI interrupts.

	-Daniel
*This .sig left intentionally blank*
