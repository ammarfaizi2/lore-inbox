Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTH0PVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTH0PVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:21:14 -0400
Received: from mail.gondor.com ([212.117.64.182]:2321 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S263459AbTH0PVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:21:00 -0400
Date: Wed, 27 Aug 2003 17:20:52 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise IDE patches
Message-ID: <20030827152052.GB25198@gondor.com>
References: <20030826223158.GA25047@gondor.com> <200308270054.27375.bzolnier@elka.pw.edu.pl> <1061996391.22825.39.camel@dhcp23.swansea.linux.org.uk> <20030827151227.GA25198@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827151227.GA25198@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 05:12:27PM +0200, Jan Niehusmann wrote:
> What do you think about a check in __ide_do_rw_disk? calling
> lba_28_rw_disk or chs_rw_disk when the block address doesn't fit in
> 28bit is surely wrong and should return an error. 

Sorry - I didn't notice that this straight forward distinction is only
possible in the CONFIG_IDE_TASKFILE_IO case. 

Jan

