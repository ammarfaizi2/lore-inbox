Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUASRsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUASRsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:48:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33937 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266547AbUASRsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:48:09 -0500
Date: Mon, 19 Jan 2004 09:40:10 -0800
From: "David S. Miller" <davem@redhat.com>
To: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: yoshfuji@linux-ipv6.org, marcel@holtmann.org, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: Re: Problem with CONFIG_SYSCTL disabled
Message-Id: <20040119094010.68fb43a7.davem@redhat.com>
In-Reply-To: <1074524771.21244.7.camel@telecentrolivre>
References: <1074519043.6070.93.camel@pegasus>
	<20040119.224603.71004956.yoshfuji@linux-ipv6.org>
	<1074521369.6070.99.camel@pegasus>
	<20040119.232131.03582632.yoshfuji@linux-ipv6.org>
	<1074524771.21244.7.camel@telecentrolivre>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 13:06:12 -0200
Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:

> > If one does not require linux/sysctl.h without CONFIG_SYSCTL,
> > you don't need to include it.
> 
>  I take a quick look, there are other places to fix. Should it be a
> janitor task ?

Yes, it's just ugly to have these ifdefs in *.c files _if_ they can be avoided.

Meanwhile I've applied the neighbour.h fix from Yoshfuji-san.
