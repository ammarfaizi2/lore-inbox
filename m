Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWATQpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWATQpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWATQpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:45:19 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:64640 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1751080AbWATQpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:45:17 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: [PATCH 000 of 5] md: Introduction
Date: Fri, 20 Jan 2006 18:05:29 GMT
Message-ID: <0610KX512@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>
> Please report any fusion problems to Eric Moore at LSI, the Adaptec driver
> must unfortunately be considered unmaintained.

Done several time over more than two years, but new versions did not solve
the problem, even if in 2.6.13 it forwards the problem to MD instead of just
locking the bus.
Also, production quality verification is something really hard to verify
since even on production servers it requires several monthes to tigger some
very rare situations, and on the production server I've finaly replaced the
partialy faulty disk so that the problem may well never append again on
the box.
So the problem is probably still there in the driver, maybe not, but I have
no way to validate new drivers.

To be more precise, last 2.4.xx have production quality fusion driver,
only 2.6.xx driver has problems.

The last point is that if you look at the last changes in the fusion driver,
they are moving evrything around to introduce the SAS, so after more than a
year of unsuccessfull reports about a single bug that appends on production
server, you can understand that my willing to make tests with potencial
production consequences has vanished.

The fusion maintainer is responsive, did his best, but could not achieve
the result, so he may have not received enough help from general kernel
maintainers, or the kernel or the fusion drivers might start to be too
complicated. I stop here because I do not want to start flames. Just report.

