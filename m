Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVDGGny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVDGGny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVDGGnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:43:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:56033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261516AbVDGGnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:43:40 -0400
Date: Wed, 6 Apr 2005 23:42:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: connector is missing in 2.6.12-rc2-mm1
Message-Id: <20050406234257.460edb9a.akpm@osdl.org>
In-Reply-To: <1112855509.18360.27.camel@frecb000711.frec.bull.fr>
References: <1112855509.18360.27.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> Hello,
> 
>  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. So it
> seems that you removed the connector?

Greg dropped it for some reason.  I think that's best because it needed a
significant amount of rework.  I'd like to see it resubitted in totality so
we can take another look at it.

It's a new piece of core kernel infrastructure and the barriers for that
are necessarily high.

> Will you include it again in futur
> release? At the same time, will you include the fork connector?

I could put the fork connector into -mm, but would like to be convinced
that it's acceptable to and useful for all system accounting requirements,
not just the one project.  That means code, please.

