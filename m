Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWHAVN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWHAVN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHAVN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:13:27 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:17400 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750736AbWHAVN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:13:26 -0400
Message-ID: <1154466739.44cfc3b34a222@portal.student.luth.se>
Date: Tue,  1 Aug 2006 23:12:19 +0200
From: ricknu-0@student.ltu.se
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Nicholas Miell <nmiell@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Noschinski <cebewee@gmx.de>
Subject: Re: [PATCH 1/2] include/linux: Defining bool, false and true
References: <1154175570.44cb5252d3f09@portal.student.luth.se> <1154176331.44cb554b633ef@portal.student.luth.se> <44CFA934.9010404@zytor.com>
In-Reply-To: <44CFA934.9010404@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar "H. Peter Anvin" <hpa@zytor.com>:

> ricknu-0@student.ltu.se wrote:
> > This patch defines:
> > * a generic boolean-type, named "bool"
> > * aliases to 0 and 1, named "false" and "true"
> > 
> > Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> Shouldn't this simply use _Bool?

Well, it is (now) just a typedef of it. :)

But I find it better, both because it is more similar to the common types:
short, lowlettered words. But also because most editors with highlightning
recognize "bool", but not "_Bool", as a type (as I found it).

> 	-hpa

/Richard Knutsson

