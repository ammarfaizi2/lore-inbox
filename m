Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266098AbUFJBpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266098AbUFJBpe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUFJBpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:45:34 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:26572 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266094AbUFJBpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:45:33 -0400
Date: Wed, 9 Jun 2004 18:45:19 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Alex Williamson <alex.williamson@hp.com>, clameter@sgi.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-ID: <20040610014519.GA3158@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com> <1086805676.4288.16.camel@tdi> <20040609130001.37a88da1.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609130001.37a88da1.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 01:00:01PM -0700, David S. Miller wrote:

> How can you legitimately change this structure?  It's an exported
> userland interface, if you change it all the applications will stop
> working.

Why not split the structure for user-space and kernel-space version
and cp/frob at/near the syscall boundary?



  --cw
