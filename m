Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263910AbUDPWug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbUDPWug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:50:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64962 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263910AbUDPWu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:50:28 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Subject: Re: Ide special case
Date: Sat, 17 Apr 2004 00:49:17 +0200
User-Agent: KMail/1.5.3
References: <1082152120.6120.3.camel@bluerhyme.real3>
In-Reply-To: <1082152120.6120.3.camel@bluerhyme.real3>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404170049.17190.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 of April 2004 23:48, Fabian Frederick wrote:
> Hi,
> 	I was looking at some IDE sources and I'm surprised to see a lot of
> pdc4030 special cases even in high level sources....Is there a reason
> for that ? (I dunno that hardware :( ).

Yes.  Hardware is non-standard and IDE chipset drivers are not
(this is slowly changing) real host drivers like SCSI chipset drivers.

Bartlomiej

