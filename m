Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUDPE73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUDPE73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:59:29 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:5760
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S262272AbUDPE70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:59:26 -0400
Date: Thu, 15 Apr 2004 21:59:24 -0700
From: Phil Oester <kernel@linuxace.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, shannon@widomaker.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040416045924.GA4870@linuxace.com>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1082084048.7141.142.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I can concur -- I recently migrated 100+ servers from 2.4.x
to 2.6.3, and simply could not use UDP mounts and achieve acceptable
performance. Further, I wasn't using 32K r/w as you posit, but was
using 8K (against a NetApp FWIW).

If simply upgrading from 2.4.x to 2.6.x is going to make UDP mounts unusable,
perhaps this should be documented -- or the option should be deprecated.

Phil Oester


On Thu, Apr 15, 2004 at 07:54:08PM -0700, Trond Myklebust wrote:
> På to , 15/04/2004 klokka 18:53, skreiv Andrew Morton:
> > But Charles was seeing good performance with 2.4-based clients.  When he
> > went to 2.6 everything fell apart.
> > 
> > Do we know why this regression occurred?
> 
> What regression??? You have a statistic of 1 person whose 3 clients
