Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbTGGHAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 03:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbTGGHAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 03:00:32 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266849AbTGGHAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 03:00:31 -0400
Date: Mon, 7 Jul 2003 08:14:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@intercode.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Spatzier <TSPAT@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
Message-ID: <20030707081458.C1848@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@intercode.com.au>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Spatzier <TSPAT@de.ibm.com>,
	linux-kernel@vger.kernel.org
References: <200307022206.h62M6aFB025817@post.webmailer.de> <Mutt.LNX.4.44.0307062353420.548-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0307062353420.548-100000@excalibur.intercode.com.au>; from jmorris@intercode.com.au on Mon, Jul 07, 2003 at 12:08:37AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 12:08:37AM +1000, James Morris wrote:
> I'm not enthusiastic about adding infrastructure which is really just a
> hack for some quaint hardware, and probably does not work towards
> addressing more common hardware requirements.

The z990 isn't really crypto hw in the traditional sense, it has special
instructions in the CPU so from Linux POV it's more an extremly optimized
SW implementation..

And we have to solve this anyway even iof support for external crypto
hw is delayed.  Think of integrating Jari's x86 assembly aes implementation
or similar things.
