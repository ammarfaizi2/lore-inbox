Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWIIW1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWIIW1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWIIW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:27:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:46528 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964980AbWIIW1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:27:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rJrFZHbPoT58mZtlVczOK16FaOjajSHqy36qzsNDjXnlWlBxpkP1wDdl0rcrII2+cgZd7HxN2bwA9FeZ1TV+WQ1GOzYAl46ueaFOq5vwd2nKJahOSJhy/Ye5nhwXWdcI0ndtoL25yVX5p5twpRMOdrkpAbBtLtAAOUM3zhzkYvM=
Date: Sun, 10 Sep 2006 02:27:18 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Message-ID: <20060909222718.GB5192@martell.zuzino.mipt.ru>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <2006-09-09-17-18-13+trackit+sam@rfc1149.net> <1157817522.6877.46.camel@localhost.localdomain> <2006-09-09-17-38-12+trackit+sam@rfc1149.net> <2006-09-09-18-28-44+trackit+sam@rfc1149.net> <20060909214941.GA5192@martell.zuzino.mipt.ru> <2006-09-10-00-11-56+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2006-09-10-00-11-56+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 12:11:56AM +0200, Samuel Tardieu wrote:
> | > +static int w83697hf_init(void)
> |
> | Can be __init?
>
> Nope, wdt_init is __init.

Functions called only from __init functions can be marked as __init. ;-)

