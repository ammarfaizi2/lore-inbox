Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275080AbTHQIpC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275082AbTHQIpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:45:02 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:56715 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275080AbTHQIpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:45:00 -0400
Subject: Re: [PATCH] 1/8 Backport recent 2.6 IDE updates to 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030817061238.GB17621@codepoet.org>
References: <20030817061238.GB17621@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061109862.21502.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 09:44:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 07:12, Erik Andersen wrote:
> This patch eliminates HDIO_GETGEO_BIG and HDIO_GETGEO_BIG_RAW,
> where are entirely unused and unnecessary.  They were also
> removed from 2.6.x,

Rejected by 2.4 IDE maintainer. Removing API's (even dumb ones) during
a stable release is not good practice. 

