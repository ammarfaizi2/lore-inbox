Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSGZTNC>; Fri, 26 Jul 2002 15:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318456AbSGZTNC>; Fri, 26 Jul 2002 15:13:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29945 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318455AbSGZTNB>; Fri, 26 Jul 2002 15:13:01 -0400
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0207261608320.3086-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207261608320.3086-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Jul 2002 12:16:14 -0700
Message-Id: <1027710974.2443.39.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 12:10, Rik van Riel wrote:

> On 26 Jul 2002, Robert Love wrote:
>
> > Better question is, why would we have page-able kernel memory?
> 
> We don't want to have generic page-able kernel memory.
> 
> However, it might be useful to be able to reclaim or page
> out data structures that might otherwise gobble up all of
> RAM and crash the machine, say page tables.

I agree a better solution than high-pte is probably needed.  Shared page
tables and/or large page tables insufficient?

	Robert Love

