Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbUJ0Uyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUJ0Uyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUJ0UwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:52:18 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:41805 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262708AbUJ0Ugd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:36:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dEvr7tzOXTY9RIaVoFTFP9LpnV7IRVOuvRJJC05w+21Hk0FewK55Xsxtv0foFQYI7va240wKJL0J2EwPnS4O2kfWPy3ZusICSSTQ9Od3s7Y17VOTU1JiLeTMTWGPtC0G7puoqB70Rfs4rxCQoPU6KRGinzmrysPYBbsbpgLJM70=
Message-ID: <58cb370e041027133616ea1e00@mail.gmail.com>
Date: Wed, 27 Oct 2004 22:36:32 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] Rename SECTOR_SIZE to BIO_SECTOR_SIZE
Cc: Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041027202924.GA20572@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041027060828.GA32396@taniwha.stupidest.org>
	 <417F4497.3020205@pobox.com>
	 <20041027065524.GA1524@taniwha.stupidest.org>
	 <20041027072212.GN15910@suse.de>
	 <20041027190523.GA19330@taniwha.stupidest.org>
	 <20041027202733.GG28904@waste.org>
	 <20041027202924.GA20572@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 13:29:24 -0700, Chris Wedgwood <cw@f00f.org> wrote:
> On Wed, Oct 27, 2004 at 03:27:33PM -0500, Matt Mackall wrote:
> 
> > So shouldn't this be in bio.h now?
> 
> in a sense, nobody else but IDE uses it, and i just noticed

Then whole rename doesn't make sense to me... sorry... :)

> SECTOR_WORDS is pretty much pointless so i can rediff fixing that
> too...

SECTOR_WORDS can die
