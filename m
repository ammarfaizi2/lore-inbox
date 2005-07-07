Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVGGG7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVGGG7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGGG5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:57:52 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53162 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261188AbVGGGzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:55:13 -0400
References: <20050707065030.4234.qmail@web81308.mail.yahoo.com>
In-Reply-To: <20050707065030.4234.qmail@web81308.mail.yahoo.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Mark Gross <mgross@linux.intel.com>, Willy Tarreau <willy@w.ods.org>,
       Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Date: Thu, 07 Jul 2005 09:55:11 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CCD1CF.00004205@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry, 

Mark Gross writes:
> > > +
> > > +/* 0 = Dynamic allocation of the major device number */
> > > +#define TLCLK_MAJOR 252

Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> > Enums, please. 
> > 

Dmitry Torokhov writes:
> But not here - it is a single constant, not a value of a distinct type.

Fair enough, "static const int" would work here too. Defines should be 
avoided because they allow you to override a value without ever noticing it. 

            Pekka 
