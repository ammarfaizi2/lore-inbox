Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWGZOvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWGZOvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWGZOvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:51:09 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:51886
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932170AbWGZOvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:51:07 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "gmu 2k6" <gmu2006@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Philipp Rumpf <prumpf@mandrakesoft.com>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Date: Wed, 26 Jul 2006 16:49:10 +0200
User-Agent: KMail/1.9.1
References: <20060725222209.0048ed15.akpm@osdl.org> <200607261544.39532.mb@bu3sch.de> <f96157c40607260721s43837f9er810da838ed56cf1b@mail.gmail.com>
In-Reply-To: <f96157c40607260721s43837f9er810da838ed56cf1b@mail.gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261649.10947.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 16:21, gmu 2k6 wrote:
> it just outputs this and stops with 2.6.18-rc2-HEAD (see dmesg for hashcode or
> whatever that is which is appended as localversion)
> 
> svn:~# hexdump /dev/hwrng
> 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 
> with 2.6.17.6:
> svn:~# hexdump /dev/hwrng
> 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 
> this was without any rng-tools installed and no rngd running of course.

Hm, so I would say the hardware either broken, or intel
changed the way to read the random data from it. But I doubt they
would change something like this on the ICH5.

Who wrote the ICH driver? Jeff? Philipp?
What do you think?

-- 
Greetings Michael.
