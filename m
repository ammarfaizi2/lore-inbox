Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVFVHqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVFVHqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVFVHpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:45:53 -0400
Received: from graphe.net ([209.204.138.32]:18624 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262713AbVFVGTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:19:13 -0400
Date: Tue, 21 Jun 2005 23:19:02 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <42B8A51A.8020208@pobox.com>
Message-ID: <Pine.LNX.4.62.0506212314270.6988@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com>
 <1119368364.3949.236.camel@betsy> <Pine.LNX.4.62.0506211222040.21678@graphe.net>
 <42B8987F.9000607@pobox.com> <Pine.LNX.4.62.0506211628550.25251@graphe.net>
 <42B8A51A.8020208@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Jeff Garzik wrote:

> > AIO is requiring you to poll and check if I/O is complete. select() does 
> 
> Incorrect.  The entire point of AIO is that its an async callback system, when
> the I/O is complete...  just like the kernel's internal I/O request queue
> system.

Hmmm.. Okay it may work like dnotify. You get some signal and 
then its up to you to figure out what was going on. Traditionally select() 
does that all for you and tells you which stream got input.

