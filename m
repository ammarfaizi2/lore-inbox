Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbRE3IcR>; Wed, 30 May 2001 04:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbRE3IcH>; Wed, 30 May 2001 04:32:07 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:64713 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262655AbRE3Ibv>; Wed, 30 May 2001 04:31:51 -0400
Date: Wed, 30 May 2001 09:30:48 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Procfs Guide
Message-ID: <20010530093048.O1332@redhat.com>
In-Reply-To: <20010530012917.E31655@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010530012917.E31655@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Wed, May 30, 2001 at 01:29:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 01:29:17AM +0200, Erik Mouw wrote:

> I'm still looking for a proper way to automatically include the example
> source into the SGML file, this patch with the same content in two
> files is a bit of an ugly hack.

Probably your best bet is to get the Makefile to pass a copy of the
real example source through sed to &entity;ify the bits that would
confuse SGML (<, >, etc), and into example.c.sed, make that into an
entity, and include it.

See <URL:http://people.redhat.com/twaugh/docbook/selfdocbook/> for
instance, which does this with its own SGML source.

Tim.
*/
