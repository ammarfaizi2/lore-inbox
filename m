Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271410AbUJVPkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271410AbUJVPkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbUJVPjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:39:02 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:35002 "EHLO
	mwinf0306.wanadoo.fr") by vger.kernel.org with ESMTP
	id S271374AbUJVPgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:36:23 -0400
Subject: Re: Buggy DSDTs policy ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: Onur Kucuk <onur@delipenguen.net>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041022151943.GA16874@ee.oulu.fi>
References: <20041022122326.GA69381@dspnet.fr.eu.org>
	 <20041022174154.2ebd2c5c.onur@delipenguen.net>
	 <1098456935.31003.77.camel@gonzales>  <20041022151943.GA16874@ee.oulu.fi>
Content-Type: text/plain; charset=utf-8
Message-Id: <1098459316.31003.93.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 17:35:16 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 22/10/2004 à 17:19, Pekka Pietikainen a écrit :
> On Fri, Oct 22, 2004 at 04:55:35PM +0200, Xavier Bestel wrote:
> > >  CONFIG_ACPI_CUSTOM_DSDT is included in 2.6.9
> > 
> > But fixed DSDTs are a pain to find, and fixing a buggy DSDT is
> > impossible for a non-hacker.
> > 
> http://acpi.sourceforge.net/dsdt/index.php has quite a few.

.. which aren't all proper fixes (I tried the DSDT for Armada 1700, it's
a partial fix only).

> The problem is getting the fixed dsdt in use without recompiling your
> kernel, since quite a few people, especially non-technical ones, use vendor
> kernels. There's an approach that uses initrd, but this isn't merged
> yet. I'd say it should be, assuming no better solution can be found.

Yes, sure. But real non-technical people won't replace their DSDT
either.

	Xav

