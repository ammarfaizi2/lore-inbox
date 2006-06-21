Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWFUBqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWFUBqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWFUBqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:46:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:61903 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751291AbWFUBqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:46:43 -0400
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060620154304.GD4845@pb15.lixom.net>
References: <20060619183315.653672000@klappe.arndb.de>
	 <20060619183404.144740000@klappe.arndb.de>
	 <20060620154304.GD4845@pb15.lixom.net>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:46:25 +1000
Message-Id: <1150854385.12507.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 10:43 -0500, Olof Johansson wrote:
> On Mon, Jun 19, 2006 at 08:33:16PM +0200, arnd@arndb.de wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > This is a first version of support for the Cell BE "Reliability,
> > Availability and Serviceability" features.
> 
> Does it really make sense to do this under a config option? I don't see
> why anyone would not want to know that their machine is about to melt.

Well, it's not quite clear yet wether that thing works at all at this
point :) It shuld be a config option (becasue those things don't make
sense on LPAR cells) but maybe not a selectable one ...

Ben.


