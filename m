Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVBXXER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVBXXER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVBXXER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:04:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:20128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262542AbVBXXEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:04:12 -0500
Date: Thu, 24 Feb 2005 15:03:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-Id: <20050224150326.3a82986c.akpm@osdl.org>
In-Reply-To: <20050224141015.GA6756@gamma.logic.tuwien.ac.at>
References: <20050125121704.GA22610@gamma.logic.tuwien.ac.at>
	<20050125102834.7e549322.akpm@osdl.org>
	<20050224141015.GA6756@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> On Die, 25 Jan 2005, Andrew Morton wrote:
>  > Norbert Preining <preining@logic.at> wrote:
>  > >
>  > > ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @ 0x00000000
>  > >  Built 1 zonelists
>  > >  __iounmap: bad address c00fffd9
> 
>  I still have this with 2.6.11-rc4-mm1 and the patch you proposed is
>  included in this kernel. Is this something I should be nervous about, or
>  is there a fix?

What does the stack backtrace from iounmap-debugging.patch say?
