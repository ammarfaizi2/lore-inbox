Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVINQRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVINQRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVINQRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:17:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55526 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030232AbVINQQ7 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:16:59 -0400
Date: Wed, 14 Sep 2005 18:16:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
In-Reply-To: <4328387E.6050701@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0509141814220.3743@scrub.home>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Nick Piggin wrote:

> Also needs work on those same architectures. Other architectures
> might want to look at providing a more optimal implementation.

IMO a rather pointless primitive, unless there is a cpu architecture which 
has a inc_not_zero instruction, otherwise it will always be the same as 
using cmpxchg.

bye, Roman
