Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUHEWda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUHEWda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267906AbUHEWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:31:48 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29119 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268000AbUHEWb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:31:26 -0400
Subject: Re: [PATCH] IDE probe delay symbol
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040804224539.GA10142@slurryseal.ddns.mvista.com>
References: <20040804224539.GA10142@slurryseal.ddns.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091741333.8364.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 22:28:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-04 at 23:45, Todd Poynor wrote:
> Since making IDE probe delays variable met with resistance, how about
> defining the magic constant in a single place and with a somewhat
> meaningful identifier?

I'd prefer not to - since right now we don't know if they are all the
same in the end. 

