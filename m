Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTFPTmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTFPTmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:42:16 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:45271
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264201AbTFPTmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:42:13 -0400
Date: Mon, 16 Jun 2003 15:56:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding technique question
Message-ID: <20030616195607.GA21660@gtf.org>
References: <3EEE2293.6010304@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEE2293.6010304@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 04:03:31PM -0400, Timothy Miller wrote:
> I believe I've seen this sort of thing done in the kernel:
> 
> do {
>     ....
>     code
>     ....
> } while (0);
> 
> 
> What I was wondering is how this is any different from:
> 
> {
>     ....
>     code
>     ....
> }

It's not... unless you're creating a function-like macro.

	Jeff



