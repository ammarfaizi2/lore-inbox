Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVAaObD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVAaObD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVAaO3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:29:48 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:42182 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261215AbVAaO1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:27:37 -0500
Date: Mon, 31 Jan 2005 15:27:46 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: inter-module-* removal.. small next step
Message-ID: <20050131142746.GD6694@wohnheim.fh-wedel.de>
References: <20050130180016.GA12987@infradead.org> <1107132112.783.219.camel@baythorne.infradead.org> <1107159869.4221.53.camel@laptopd505.fenrus.org> <20050131135631.GA6694@wohnheim.fh-wedel.de> <1107180407.19262.164.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1107180407.19262.164.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 January 2005 14:06:47 +0000, David Woodhouse wrote:
> On Mon, 2005-01-31 at 14:56 +0100, Jörn Engel wrote:
> > 
> > How about this one?  It's actually less messy inside kernel/Makefile.
> > 
> > Completely untested, though.
> 
> Surely it would suffice just to make MTD_GEN_PROBE and MTD_DOCPROBE
> select it, rather than all the _users_ of each?

Agreed.  Actually, those two should be selected by their respective
users, instead of the current *cough* logic.

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams
