Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWAMLGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWAMLGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWAMLGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:06:51 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63900 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030329AbWAMLGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:06:51 -0500
Subject: Re: linux-2.6.15-git7: PS/2 keyboard dies on ppp traffic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060112224301.74b8875f.akpm@osdl.org>
References: <43C66E82.4030106@ums.usu.ru>
	 <20060112224301.74b8875f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Jan 2006 11:10:13 +0000
Message-Id: <1137150613.4419.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-12 at 22:43 -0800, Andrew Morton wrote:
> >  infinitely replicated several last packets. events/0 consumes all the 
> >  CPU. tty buffering revamping patch is the obvious candidate, but I 
> >  haven't tried to revert it yet.
> 
> Darn, I hadn't thought of that.  Yes tty-revamp might be the culprit.

That sounds like the bug that Paul fixed.

Alan

