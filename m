Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbUBZSEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUBZSEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:04:47 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:36260 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262846AbUBZSDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:03:18 -0500
Subject: Re: [PATCH][1/2] dm-crypt cleanups
From: Christophe Saout <christophe@saout.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <403E2B14.7060003@pobox.com>
References: <20040226162324.GA12597@leto.cs.pocnet.net>
	 <403E2B14.7060003@pobox.com>
Content-Type: text/plain
Message-Id: <1077818594.14027.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 19:03:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 26.02.2004 schrieb Jeff Garzik um 18:21:

> Looks good, except that PFX should be defined to "dm-crypt: " to reduce 
> confusion...  "crypt" is rather generic, and could be construed to be 
> unrelated to your module.

It's prefixed by "device-mapper: " anyway (DMWARN, DMINFO, etc...), so
the dm- is redundant.


