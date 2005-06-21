Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVFUTXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVFUTXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVFUTXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:23:18 -0400
Received: from graphe.net ([209.204.138.32]:19416 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262214AbVFUTXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:23:03 -0400
Date: Tue, 21 Jun 2005 12:22:56 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Robert Love <rml@novell.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <1119368364.3949.236.camel@betsy>
Message-ID: <Pine.LNX.4.62.0506211222040.21678@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com>
 <1119368364.3949.236.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Robert Love wrote:

> > We should ask hpa what he needs for kernel.org.  Ideally kernel.org 
> > probably wants <something> that facilitates listening to <something> for 
> > a list of files being changed.  That would greatly speed up the robots, 
> > and possibly rsync-like activities too.
> 
> I've talked to some people who've hooked inotify into rsync
> successfully.  Cool hack.

I noticed that select() is not working on real files. Could inotify 
be used to fix select()?

