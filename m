Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTJKHyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 03:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTJKHyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 03:54:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38081 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263259AbTJKHyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 03:54:22 -0400
Date: Sat, 11 Oct 2003 09:51:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Gabor MICSKO <gmicsko@szintezis.hu>
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
In-Reply-To: <1065702208.5268.0.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.56.0310110950460.4585@earth>
References: <3F77F752.7020404@externet.hu>  <Pine.LNX.4.56.0309301655330.9692@localhost.localdomain>
  <3F854C13.3010902@freemail.hu> <1065702208.5268.0.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003, Arjan van de Ven wrote:

> > Shared library randomisation test        : No randomisation  *** this changed ***
> 
> this is because you're running prelink to fix all libs into place...

also, prelink in Fedora randomizes as well (globally), and will run as a
daily cronjob which changes the randomization each time.

	Ingo
