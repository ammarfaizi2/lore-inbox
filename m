Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWECU6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWECU6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWECU6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:58:47 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:38123 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S1751157AbWECU6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:58:46 -0400
Date: Wed, 3 May 2006 23:00:35 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Francois Romieu <romieu@fr.zoreil.com>, David Vrabel <dvrabel@cantab.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] ipg: leaks in ipg_probe
Message-ID: <20060503205945.GA18353@fargo>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	Francois Romieu <romieu@fr.zoreil.com>,
	David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231050.GC7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020936420.4066@sbz-30.cs.Helsinki.FI> <20060502183313.GA26357@electric-eye.fr.zoreil.com> <1146596687.13675.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1146596687.13675.1.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns2.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pleyades.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On May 02 at 10:04:47, Pekka Enberg wrote:
> > No clear idea but it matches the significant part of the BAR register
> > for the 256 bytes of I/O space that the device uses.
> 
> OK. David & David, would appreciate if either you could give the patch a
> spin with Francois' changes. Thanks.

I applied latest Francois patch and the changes (and specially the dma
changes) seems to be ok.

On the other hand i'm having some problems. Nothing related to the
patches, because it happens with the original driver too: After some
time using it, the driver becomes unresponsive and i need to restart
the interface and/or unload-load the ipg module. I'd need to compile
it with debug enabled when i have some time to see what it's going
on...

cheers,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
