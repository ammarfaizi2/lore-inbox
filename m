Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbTIEIQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTIEIQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:16:43 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:62731 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S262338AbTIEIQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:16:40 -0400
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
References: <Pine.GSO.4.33.0309021744290.13584-100000@sweetums.bluetronic.net>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Ricky Beam <jfbeam@bluetronic.net>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Date: Fri, 05 Sep 2003 10:16:38 +0200
In-Reply-To: <Pine.GSO.4.33.0309021744290.13584-100000@sweetums.bluetronic.net> (Ricky
 Beam's message of "Tue, 2 Sep 2003 17:52:29 -0400 (EDT)")
Message-ID: <87znhjr6op.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam <jfbeam@bluetronic.net> writes:

> On Sun, 31 Aug 2003, Florian Weimer wrote:
>>The ISP can do several things to prioritize production traffic or drop
>>malicious traffic.  However, this isn't trivial and requires careful
>>planning, and it's unlikely that anyone who is able to would want to
>>do this for a T1 customer (typically, it requires "unusual"
>>configuration of vital production routers with the fat pipes).
>
> In the cisco world, all it takes is:
> 	interface <foo>
> 	  fair-queue

WFQ is already the default for low-bandwidth links (and it obviously
can't work on high-end routers). 8-/
