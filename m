Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbTFRASe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTFRASe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:18:34 -0400
Received: from [198.184.232.17] ([198.184.232.17]:2689 "EHLO
	swordfish.capgemini.hu") by vger.kernel.org with ESMTP
	id S265029AbTFRASd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:18:33 -0400
Date: Wed, 18 Jun 2003 02:33:14 +0200
From: Nagy Gabor <linux42@freemail.c3.hu>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70 module autoloading problem
Message-ID: <20030618003314.GC2413@swordfish.capgemini.hu>
References: <20030606141710.GA254@swordfish.capgemini.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606141710.GA254@swordfish.capgemini.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Jun-06 16:17, Nagy Gabor wrote:
> Hi!
> 
> I wanted to test 2.5, and so I did with 2.5.67 first, then with 2.5.70
> 
> I have installed  the module-init-tools 0.9.11-1 debian package, and now
> some of my modules work automatically under 2.5 too, others don't get
> autoloaded.
> 
> I don't know if this is a bug in the kernel (kmod), or just something has
> changed so much without warning, that it breaks other things.

I have changed kmod.c to print every module name it tries to load.
I noted that it tried to load char-major-10-1 (psaux), and isofs, and
that kmod did not print the message when accessing /dev/input/mousr

Regards,
G
