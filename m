Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271933AbTHMMMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272011AbTHMMMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:12:08 -0400
Received: from mail.gondor.com ([212.117.64.182]:28937 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S271933AbTHMMMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:12:06 -0400
Date: Wed, 13 Aug 2003 14:12:04 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813121204.GA10577@gondor.com>
References: <20030806150335.GA5430@gondor.com> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk> <20030813005057.A1863@pclin040.win.tue.nl> <200308130221.26305.bzolnier@elka.pw.edu.pl> <20030813080309.GB2006@gondor.com> <1060773360.8009.11.camel@localhost.localdomain> <20030813112005.GB8798@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813112005.GB8798@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:20:05PM +0200, Jan Niehusmann wrote:
> On Wed, Aug 13, 2003 at 12:16:09PM +0100, Alan Cox wrote:
> > That sounds about right for UDMA33, which is what you'd get without the
> > fix I sent Marcelo a few days ago
> 
> But I've not yet patched the kernel, and while booting it says:

Ah sorry, I just had a look at the patch, and it seems like I'd get
UDMA33 even though UDMA100 is reported, without that patch. So yes, this
explains the slow speed.

Jan

