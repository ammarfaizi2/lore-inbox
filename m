Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTH0PgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTH0Pf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:35:59 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:929 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263436AbTH0Pf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:35:59 -0400
Subject: Re: [PATCH] Backport recent IDE updates, take 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030822221109.GB3802@codepoet.org>
References: <20030817061225.GA17621@codepoet.org>
	 <20030822221109.GB3802@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061998505.22721.54.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 16:35:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-22 at 23:11, Erik Andersen wrote:
> CHS), and sanely clamps LBA48 when not doing DMA, preventing data
> corruption, and avoids idedisk_supports_host_protected_area()

Doesnt seem to do that right. Marcelo, please don't apply any of this
stuff until someone actually fixes the lba48 clipping properly

