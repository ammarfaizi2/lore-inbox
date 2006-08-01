Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWHATUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWHATUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWHATUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:20:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25768 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751835AbWHATUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:20:39 -0400
Message-ID: <44CFA934.9010404@zytor.com>
Date: Tue, 01 Aug 2006 12:19:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
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
References: <1154175570.44cb5252d3f09@portal.student.luth.se> <1154176331.44cb554b633ef@portal.student.luth.se>
In-Reply-To: <1154176331.44cb554b633ef@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> This patch defines:
> * a generic boolean-type, named "bool"
> * aliases to 0 and 1, named "false" and "true"
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

Shouldn't this simply use _Bool?

	-hpa
