Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTKZOgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 09:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTKZOgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 09:36:42 -0500
Received: from holomorphy.com ([199.26.172.102]:50109 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263591AbTKZOgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 09:36:41 -0500
Date: Wed, 26 Nov 2003 06:36:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
Message-ID: <20031126143635.GQ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ihar 'Philips' Filipau <filia@softhome.net>,
	root@chaos.analogic.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos> <3FC3E2F4.4080809@softhome.net> <Pine.LNX.4.53.0311260745190.9601@chaos> <3FC4A8BA.9070907@softhome.net> <20031126132719.GP8039@holomorphy.com> <3FC4B9A2.7050204@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC4B9A2.7050204@softhome.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 03:33:06PM +0100, Ihar 'Philips' Filipau wrote:
>   How can I tell the limit of the RAM which can be locked?
>   My test had shown that single application can lock 112MB of RAM, but 
> fails to lock 128MB of RAM. (I have 256MB phy RAM - We just cannot find 
> smaller memory modules on market in any way :-))
>   Is it limited to less than half of physical RAM?
>   This would be Ok for me in any way.

The limit should be available RAM.


-- wli
