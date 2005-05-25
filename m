Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVEYPko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVEYPko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVEYPko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:40:44 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59332 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262378AbVEYPkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:40:31 -0400
Date: Wed, 25 May 2005 17:40:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Arjan van de Ven <arjan@infradead.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, arjan@pentafluge.infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Add "FORTIFY_SOURCE" to the linux kernel
In-Reply-To: <1117032436.6010.76.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0505251736550.997@scrub.home>
References: <20050525084332.GA16865@pentafluge.infradead.org> 
 <4294891E.4070702@vc.cvut.cz> <1117032436.6010.76.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 May 2005, Arjan van de Ven wrote:

> Or, alternatively, in your module UNDEF the config option before
> including these headers.

Eeek, you don't mean this seriously?
_No_ module should screw around with the config symbols.

bye, Roman
