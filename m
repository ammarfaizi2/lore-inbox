Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281395AbRKEWRH>; Mon, 5 Nov 2001 17:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281396AbRKEWQ6>; Mon, 5 Nov 2001 17:16:58 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:5334 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281395AbRKEWQy>; Mon, 5 Nov 2001 17:16:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Mon, 5 Nov 2001 23:19:51 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160qaQ-2523rUC@fmrl04.sul.t-online.com> <20011105150441.D4735@kroah.com>
In-Reply-To: <20011105150441.D4735@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160s2v-19Yq7UC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 November 2001 00:04, Greg KH wrote:
> The contents of /proc/bus/usb is the usbdevfs file system.  It does not
> fit into the current /proc model, or discussion.

It's just a example of a complex data structure that cannot easily be 
represented using the tagged-list form (I took it as an example because the 
first version of the devreg patch used tagged lists, too, and the complexity 
of representing this USB structure convinced me that tagged-lists are too 
limited). 
Whatever format is chosen for proc, it should be used for all data.

bye...


