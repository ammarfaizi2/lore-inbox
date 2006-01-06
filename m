Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWAFRbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWAFRbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWAFRbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:31:32 -0500
Received: from mail.dvmed.net ([216.237.124.58]:7084 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932515AbWAFRbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:31:31 -0500
Message-ID: <43BEA970.4050704@pobox.com>
Date: Fri, 06 Jan 2006 12:31:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544309.2940.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1136544309.2940.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Arjan van de Ven wrote: > Subject: when
	CONFIG_CC_OPTIMIZE_FOR_SIZE, allow gcc4 to control inlining > From:
	Ingo Molnar <mingo@elte.hu> > > if optimizing for size
	(CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers > to decide what to
	inline and what not - instead of the kernel forcing gcc > to inline all
	the time. This requires several places that require to be > inlined to
	be marked as such, previous patches in this series do that. > This is
	probably the most flame-worthy patch of the series. > > Signed-off-by:
	Ingo Molnar <mingo@elte.hu> > Signed-off-by: Arjan van de Ven
	<arjan@infradead.org> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Subject: when CONFIG_CC_OPTIMIZE_FOR_SIZE, allow gcc4 to control inlining
> From: Ingo Molnar <mingo@elte.hu>
> 
> if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
> to decide what to inline and what not - instead of the kernel forcing gcc
> to inline all the time. This requires several places that require to be 
> inlined to be marked as such, previous patches in this series do that.
> This is probably the most flame-worthy patch of the series.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>

NAK, for what it's worth...  This should be first integrated with its 
own "off switch", and then later added to optimze-for-size.

	Jeff



