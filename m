Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVINQcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVINQcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVINQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:32:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57318 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030260AbVINQcI (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:32:08 -0400
Date: Wed, 14 Sep 2005 18:31:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
In-Reply-To: <43283B66.8080005@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0509141829050.3743@scrub.home>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
 <432838E8.5030302@yahoo.com.au> <432839F1.5020907@yahoo.com.au>
 <43283B66.8080005@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Nick Piggin wrote:

> Is there any point in keeping this around?

Yes, for drivers which want to use it to synchronize with userspace.
Alternatively it could be changed into a Kconfig definition.

bye, Roman
