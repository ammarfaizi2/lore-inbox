Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVEQRZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVEQRZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEQRYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:24:35 -0400
Received: from graphe.net ([209.204.138.32]:784 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261864AbVEQRVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:21:00 -0400
Date: Tue, 17 May 2005 10:20:49 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
In-Reply-To: <828790000.1116349787@flay>
Message-ID: <Pine.LNX.4.62.0505171020130.10798@graphe.net>
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net>
 <826450000.1116349699@flay> <828790000.1116349787@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Martin J. Bligh wrote:

> > Nope. same failure.
> 
> Oops. I lie. Now it gets the other failure (the panic on boot we were
> discussing before). So yes, that patch worked.

You removed the slab patches right? So this confirms that the panic on 
boot has nothing to do with the numa slab allocator?
