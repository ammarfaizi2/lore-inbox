Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUHGQcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUHGQcR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUHGQcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:32:17 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:29635 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S263664AbUHGQcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:32:16 -0400
Date: Sat, 7 Aug 2004 12:27:46 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040807162746.GQ23994@certainkey.com>
References: <cemgno$hun$2@abraham.cs.berkeley.edu> <Xine.LNX.4.44.0408021905320.2260-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408021905320.2260-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 07:16:56PM -0400, James Morris wrote:
> On Mon, 2 Aug 2004, David Wagner wrote:
> 
> > The point I was making is that there are other scenarios where Cryptoloop
> > falls apart in much more devastating ways.  For instance, if the attacker
> > can modify the ciphertexts stored on your hard disk and you continue
> > using the hard disk afterwards, then really nasty attacks become possible.
> > Other attacks become possible if the attacker can observe the ciphertexts
> > stored on your hard disk at multiple points in time.  The question I was
> > asking is this: Does anyone care about these latter types of scenarios?
> 
> I think the common threat scenarios out of the above are:
> 
> 1) Attacker can observe ciphertexts at multiple points in time.
> 2) Attacker steals disk/computer and disappears with it.

Examples for #1 being: mounting a file system image across NFS (their home
directory for example).  In this case, and attacker can see almost *all* disk
reads and writes.

Thanks for your input on this David W., I was @ OLS... silly intermittent
WiFi...

JLC
