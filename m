Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272161AbTHDTdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272167AbTHDTdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:33:09 -0400
Received: from almesberger.net ([63.105.73.239]:24581 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S272161AbTHDTdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:33:06 -0400
Date: Mon, 4 Aug 2003 16:32:56 -0300
From: Werner Almesberger <werner@almesberger.net>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030804163256.M5798@almesberger.net>
References: <g83n.8vu.9@gated-at.bofh.it> <3F2CFC80.4090401@softhome.net> <20030803151000.D10280@almesberger.net> <3F2E1F7B.3020906@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2E1F7B.3020906@softhome.net>; from filia@softhome.net on Mon, Aug 04, 2003 at 10:55:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:
>    It makes not that much sense to run kernel (especially Linux) on CPU 
> which is optimized for handling of network packets. (And has actually 
> several co-processors to help in this task).

All you need to do is to make the CPU capable of running the kernel
(well, some of it), but it doesn't have to be particularly good at
running anything but the TCP/IP code. And you can still benefit
from most of the features of NPUs, such as a specialized memory
architecture, parallel data paths, accelerated operations, etc.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
