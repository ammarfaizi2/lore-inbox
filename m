Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUE1NJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUE1NJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUE1NJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:09:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1789 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263093AbUE1NJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:09:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Auzanneau Gregory <mls@reolight.net>
Subject: Re: idebus setup problem (2.6.7-rc1)
Date: Fri, 28 May 2004 15:10:25 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0405281244220.22881-100000@mazda.sh.intel.com> <200405281450.22879.bzolnier@elka.pw.edu.pl> <40B7362B.8050905@reolight.net>
In-Reply-To: <40B7362B.8050905@reolight.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405281510.25256.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 of May 2004 14:52, Auzanneau Gregory wrote:
> Bartlomiej Zolnierkiewicz a écrit :
> > OK, now please explain why do you use 'idebus=66'. :-)
>
> Because my SIS 5513 southbridge seems to run by default to 33Mhz.

and you run PCI bus at 66MHz?

SiS IDE driver completely ignores 'idebus' parameter.

