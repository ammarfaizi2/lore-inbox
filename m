Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWIMNIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIMNIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWIMNIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:08:07 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:41624 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750762AbWIMNIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:08:05 -0400
Date: Wed, 13 Sep 2006 09:07:53 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm patch] AVR32: Remove set_wmb()
In-Reply-To: <20060913100708.39735131@cad-250-152.norway.atmel.com>
Message-ID: <Pine.LNX.4.58.0609130904001.3057@gandalf.stny.rr.com>
References: <20060913100708.39735131@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2006, Haavard Skinnemoen wrote:

> Remove definition of set_wmb on AVR32 since it isn't used. This has
> already been done for all other architectures by commit
> 52393ccc0a53c130f31fbbdb8b40b2aadb55ee72 in Linus' tree.
>

Hmm, I missed one :(

Acked-by: Steven Rostedt <rostedt@goodmis.org>


> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> ---
