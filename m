Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266797AbUGVDa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266797AbUGVDa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 23:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266799AbUGVDa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 23:30:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1194 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266797AbUGVDa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 23:30:58 -0400
Date: Wed, 21 Jul 2004 23:30:18 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
In-Reply-To: <20040721230044.20fdc5ec.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407212319560.13098@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
 <20040721230044.20fdc5ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004, Andrew Morton wrote:

> > which is buggy, unmaintained, and
> > reportedly has mutliple security weaknesses.
> 
> Doesn't dm-crypt have the same security weaknesses?

Jari Ruusu claims that anything with on-disk cryptoloop compatibility is 
vulnerable to dictionary attacks and IV deduction.  Fruhwirth Clemens 
claims that this is FUD, per the thread below.

http://marc.theaimsgroup.com/?l=linux-kernel&m=108447509327847&w=2

It would be good if we could get some further review on the issue by an 
independent, well known cryptographer.


- James
-- 
James Morris
<jmorris@redhat.com>

