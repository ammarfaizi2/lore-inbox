Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVA2STg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVA2STg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVA2SRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:17:13 -0500
Received: from mail.enyo.de ([212.9.189.167]:33426 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261419AbVA2SQY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:16:24 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
References: <1106932637.3778.92.camel@localhost.localdomain>
Date: Sat, 29 Jan 2005 19:16:17 +0100
In-Reply-To: <1106932637.3778.92.camel@localhost.localdomain> (Lorenzo
	=?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro's?= message of "Fri, 28 Jan 2005
 18:17:17
	+0100")
Message-ID: <87hdl0p0cu.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Hernández García-Hierro:

> As it's impact is minimal (in performance and development/maintenance
> terms), I recommend to merge it, as it gives a basic prevention for the
> so-called system fingerprinting (which is used most by "kids" to know
> how old and insecure could be a target system, many time used as the
> first, even only-one, data to decide if attack or not the target host)
> among other things.

The most important result of such a patch is source port randomization
for DNS queries to resolvers.  This gives you a few more bits (DNS
itself has just a 16 bit "unique" ID, which isn't too hard to
brute-force these days, unfortunately).
