Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVKPPS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVKPPS1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVKPPS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:18:27 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:28839 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030367AbVKPPS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:18:26 -0500
Date: Wed, 16 Nov 2005 16:18:24 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051116151824.GB24753@wohnheim.fh-wedel.de>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <1132128212.2834.17.camel@laptopd505.fenrus.org> <20051116111812.4a1ea18a.grundig@teleline.es> <1132137638.2834.29.camel@laptopd505.fenrus.org> <p73oe4kpx6n.fsf@verdi.suse.de> <20051116135116.GA24753@wohnheim.fh-wedel.de> <437B453E.8070905@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <437B453E.8070905@utah-nac.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 November 2005 07:42:06 -0700, jmerkey wrote:
> >
> Map a blank ro page beneath the address range when stack memory is 
> mapped is trap on page faults to the page when folks go off the end of 
> th e stack.

You forgot the part with the testcase that will trigger every single
possible stack overflow.

> Easy to find.

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown
