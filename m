Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWHAVrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWHAVrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWHAVrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:47:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61374 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751042AbWHAVrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:47:24 -0400
Message-ID: <44CFCBE5.5080900@garzik.org>
Date: Tue, 01 Aug 2006 17:47:17 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
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
References: <1154175570.44cb5252d3f09@portal.student.luth.se> <1154176331.44cb554b633ef@portal.student.luth.se> <44CFA934.9010404@zytor.com> <44CFC669.1040709@garzik.org> <44CFCA98.4080400@zytor.com>
In-Reply-To: <44CFCA98.4080400@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> That wasn't the point.  The point was that bool should be a typedef to 
> _Bool instead of an enum.

Quoting from the patch to which you are replying:

	+typedef _Bool			bool;

'enum' is only used for defining 'true' and 'false'.

	Jeff


