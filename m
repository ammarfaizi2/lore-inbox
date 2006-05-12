Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWELHnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWELHnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWELHnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:43:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751056AbWELHnY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:43:24 -0400
Date: Fri, 12 May 2006 00:40:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. =?ISO-8859-1?B?TWFnYWxs824i?= <jamagallon@ono.com>"@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3-mm1
Message-Id: <20060512004025.73ab433d.akpm@osdl.org>
In-Reply-To: <20060512092538.6c3ee3de@werewolf.auna.net>
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	<20060512092538.6c3ee3de@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallón" <jamagallon@ono.com> wrote:
>
> On Mon, 1 May 2006 01:47:37 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/
> > 
> 
> I have just noticed that the support for 1Gb low mem has been dropped.
> Any poblems, is it considered a disgusting hack or just by acccident ?
> 

It's risky and breaks stuff and caused Andi to go on an extensive debugging
session because someone diddled with it.

So we hid it behind CONFIG_EMBEDDED, which has kinda come to mean
CONFIG_YOU_DONT_WANT_TO_FUTZ_WITH_THIS_STUFF.
