Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSE0Q35>; Mon, 27 May 2002 12:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSE0Q34>; Mon, 27 May 2002 12:29:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57070 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316675AbSE0Q3z>; Mon, 27 May 2002 12:29:55 -0400
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020527145420.GA6738@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 18:31:16 +0100
Message-Id: <1022520676.11859.294.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 15:54, J.A. Magallon wrote:

> +static void __init check_intel_compat(struct cpuinfo_x86 *c)
> +{
> +#if defined(CONFIG_MPENTIUMII) || defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
> +	if (c->x86 <= 5)
> +		panic("Kernel is unsafe/incompatible with this CPU model. Check your build settings !\n");
> +#endif

The PPro is also model 6 but a different family (1 if I remember
rightly)

