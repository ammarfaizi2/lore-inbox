Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWGRW4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWGRW4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWGRW4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:56:24 -0400
Received: from gw.goop.org ([64.81.55.164]:58039 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932402AbWGRW4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:56:06 -0400
Message-ID: <44BD4956.5020706@goop.org>
Date: Tue, 18 Jul 2006 13:49:26 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [RFC PATCH 09/33] Add start-of-day setup hooks to subarch
References: <20060718091807.467468000@sous-sol.org>	 <20060718091950.750213000@sous-sol.org> <1153217033.3038.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1153217033.3038.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> what is this for? Isn't this 1) undocumented and 2) unclear and 3)
> ugly ? (I'm pretty sure the HAVE_ARCH_* stuff is highly deprecated for
> new things nowadays)
>   

It appears to be completely unnecessary.  Xen doesn't use 
sanitize_e820_map(), but there's no obvious harm in leaving it there 
(and it's init code, so there's no long-term cost).


    J

