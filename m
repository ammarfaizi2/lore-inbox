Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUHPPfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUHPPfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267687AbUHPPef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:34:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50922 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267783AbUHPP3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:29:16 -0400
Date: Mon, 16 Aug 2004 11:28:16 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: fixup incomplete ident blocks on ITE raid volumes
Message-ID: <20040816152816.GD10279@devserv.devel.redhat.com>
References: <20040815144527.GA7983@devserv.devel.redhat.com> <200408161716.35922.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408161716.35922.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 05:16:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This should be part of ITE driver patch and be compiled only when ITE driver 
> is going to be used or even better - there should be new callback for that.

Nice theory but doesn't work that way. The ITE drive will do this even if
you don't have the ITE driver compiled in because it'll be seen as the
mainboard legacy controller (or generic) in some systems.

Alan

