Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUGAVCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUGAVCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUGAVCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:02:50 -0400
Received: from av9-2-sn4.m-sp.skanova.net ([81.228.10.107]:41641 "EHLO
	av9-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S266287AbUGAVCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:02:48 -0400
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DVD+RW support for 2.6.7-bk13
References: <m2hdsr6du0.fsf@telia.com> <20040701161620.GA2939@animx.eu.org>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Jul 2004 23:02:40 +0200
In-Reply-To: <20040701161620.GA2939@animx.eu.org>
Message-ID: <m2u0wr4f0v.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner <wakko@animx.eu.org> writes:

> > This patch adds support for using DVD+RW drives as writable block
> > devices under the 2.6.7-bk13 kernel.
> > 
> > The patch is based on work from:
> > 
> >         Andy Polyakov <appro@fy.chalmers.se> - Wrote the 2.4 patch
> >         Nigel Kukard <nkukard@lbsd.net> - Initial porting to 2.6.x
> > 
> > It works for me using an Iomega Super DVD 8x USB drive.
> 
> Any chance of this working with dvd±r?  (Same question for cd-r on the other
> patch).

No, not for now. I think support for non-rewritable media requires
changes both in the udf filesystem and in the pktcdvd driver.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
