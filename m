Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272578AbRHaBX2>; Thu, 30 Aug 2001 21:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272579AbRHaBXJ>; Thu, 30 Aug 2001 21:23:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41990 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272578AbRHaBXD>; Thu, 30 Aug 2001 21:23:03 -0400
Subject: Re: Linux 2.4.9-ac5
To: kaos@ocs.com.au (Keith Owens)
Date: Fri, 31 Aug 2001 02:26:09 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <8483.999220293@kao2.melbourne.sgi.com> from "Keith Owens" at Aug 31, 2001 11:11:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cd4T-0002Hm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you need for licence support in modutils?  Obviously modinfo
> needs to print it, but what about insmod?  Should insmod issue warning
> messages for proprietary modules?  What about ksymoops?  IOW, what was
> the reason for adding MODULE_LICENSE?

My goal is to eventually include the info tucked away on oops report lines
so that I can automatically dump bug reports with binary drivers, including
the growing number of people who lie about nvdriver and think that this will
get their bug cured.

insmod warnings is something I want to stay out of. I think thats up to
vendors and the like. I want to tell if people loaded crud I dont want
to tell them not to...

Alan

