Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbTFRUwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbTFRUwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:52:30 -0400
Received: from AMarseille-201-1-6-244.w80-11.abo.wanadoo.fr ([80.11.137.244]:8743
	"EHLO gaston") by vger.kernel.org with ESMTP id S265527AbTFRUw3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:52:29 -0400
Subject: Re: Radeonfb update and fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Toplica =?iso-8859-2?Q?Tanaskovi=E6?= <toptan@sezampro.yu>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200306182238.09581.toptan@sezampro.yu>
References: <200306182238.09581.toptan@sezampro.yu>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Message-Id: <1055970376.13215.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jun 2003 23:06:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 22:38, Toplica Tanaskoviæ wrote:
> 	Hi, everyone!
> 
> 	This patch does two things:
> 
> 	1. Adds RV250 (R9000 series) Radeon to radeon framebuffer files.
> 	2. Fixes small but annoying bug for Radeon P/M users. The brake was missing 
> in case so -ENODEV was returned for this card.
> 
> 	It applies to 2.4.21 and 2.4.21-ac1, both.

Well... ATI keeps claiming there is no such thing as Radeon P/M, there
is indeed a mach64 P/M chip and the device ID there matches a mach64
chip. Do you own such a thing that works with radeonfb or knows somebody
who do ?

Ben.

