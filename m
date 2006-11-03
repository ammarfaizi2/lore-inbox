Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752926AbWKCBnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbWKCBnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbWKCBnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:43:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752925AbWKCBnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:43:31 -0500
Date: Thu, 2 Nov 2006 17:43:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-Id: <20061102174326.9c25408b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611030223190.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
	<454A76CC.6030003@cosmosbay.com>
	<Pine.LNX.4.64.0611030223190.7781@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 02:28:17 +0100 (CET)
Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:

> RCU is for non-blocking operation only.

We have SRCU now, which allegedly permits sleeping inside the critical section.
