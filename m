Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVEXEnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEXEnF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 00:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVEXEnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 00:43:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:46286 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261251AbVEXEnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 00:43:03 -0400
Subject: RE: ide-cd vs. DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: karim@opersys.com, Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <18DFD6B776308241A200853F3F83D50702128D31@pl6w2kex.lan.powerlandcomputers.com>
References: <18DFD6B776308241A200853F3F83D50702128D31@pl6w2kex.lan.powerlandcomputers.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 14:42:45 +1000
Message-Id: <1116909765.4992.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 23:26 -0500, Chad Kitching wrote:
> Are you using hdparm -k1 to keep your settings over a reset?  If you're 
> not, then this behaviour is really by-design.

And is broken. You can't expect users to play with hdparm and it's quite
common to have things like CSS or region errors on a DVD, taht shouldn't
turn your DMA off on the CD.

Damn, we are in 2005 folks !

Ben;

