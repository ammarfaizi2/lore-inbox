Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268063AbUHaMIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268063AbUHaMIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUHaMIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:08:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10398 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268063AbUHaMH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:07:57 -0400
Date: Tue, 31 Aug 2004 14:07:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm Kconfig fixes
In-Reply-To: <20040828214344.GM21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0408311348510.981@scrub.home>
References: <200408280309.i7S39PPv000756@hera.kernel.org> <20040828210533.GD6301@redhat.com>
 <20040828221345.A11901@infradead.org> <20040828211717.GF6301@redhat.com>
 <20040828222206.A11969@infradead.org> <20040828214344.GM21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> BTW, AFAICS a legitimate form of negative dependency is && (!FOO || BROKEN)
> and it's common enough to consider adding a separate
> 	broken if <expression>
> to config language.  It would be interpreted as && (!<expr> || BROKEN) added
> to dependencies, but would document the situation better.

It looks ok, but the part I wouldn't like is to hardcode this into the 
parser, if someone comes up with a decent syntax to define this 
dynamically, it would be ok with me.

bye, Roman
