Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSFTQjH>; Thu, 20 Jun 2002 12:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSFTQjF>; Thu, 20 Jun 2002 12:39:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53244 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315260AbSFTQhw>; Thu, 20 Jun 2002 12:37:52 -0400
Subject: Re: [PATCH] 2.5-dj: configurable NR_CPUS
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020620160058.GA9813@werewolf.able.es>
References: <1024533919.921.46.camel@sinai> 
	<20020620160058.GA9813@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 09:37:45 -0700
Message-Id: <1024591065.921.132.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-20 at 09:00, J.A. Magallon wrote:

> On 2002.06.20 Robert Love wrote:
>
> >Attached patch is a lovely rendition of the CONFIG_NR_CPUS patch Andrew
> >and I have been tossing around.
> >
> 
> Default for alpha is missing ?

No... the default in 64 in config.in.  Do you mean there is no defconfig
entry?  Well that is because CONFIG_SMP is not set and CONFIG_NR_CPUS is
dependent on it.

	Robert Love

