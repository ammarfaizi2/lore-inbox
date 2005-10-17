Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVJQSFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVJQSFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJQSFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:05:51 -0400
Received: from 217-195-233-66.dsl.esined.net ([217.195.233.66]:25552 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932099AbVJQSFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:05:50 -0400
Subject: Re: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named
	'flip'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Damir Perisa <damir.perisa@solnet.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200510171229.57785.damir.perisa@solnet.ch>
References: <20051016154108.25735ee3.akpm@osdl.org>
	 <200510171229.57785.damir.perisa@solnet.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Oct 2005 19:05:45 +0100
Message-Id: <1129572346.2424.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-17 at 12:29 +0200, Damir Perisa wrote:
> just found that jsm-tty is still not compiling:
> 
>   LD      drivers/serial/jsm/built-in.o
>   CC [M]  drivers/serial/jsm/jsm_driver.o


The authors haven't updated it to the new tty buffering API and its the
one driver which is so complex and so abuses the interface [mostly
because the old API was inadequate for it] that I couldn't see how to
fix it and it needers a fixer with hardware and docs.

Alan

