Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWG3T5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWG3T5W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWG3T5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:57:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6813 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932453AbWG3T5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:57:21 -0400
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060730125115.d9f9d625.akpm@osdl.org>
References: <200607301830.01659.jesper.juhl@gmail.com>
	 <200607301835.35053.jesper.juhl@gmail.com>
	 <20060730113416.7c1d8f80.pj@sgi.com>
	 <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
	 <20060730120631.9ee1ab09.akpm@osdl.org>
	 <9a8748490607301217g1edad85dre8a45457c57bee35@mail.gmail.com>
	 <20060730125115.d9f9d625.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 30 Jul 2006 21:57:15 +0200
Message-Id: <1154289436.2941.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well actually when struct mutex went in we decided to remove all
> non-counting uses of semaphores kernel-wide, migrating them to mutexes. 
> Then to remove all the arch-specific semaphore implementations and
> implement an arch-neutral version.  After that has been done would be an
> appropriate time to rename things.
> 
> But it never happened.  See "fine intentions", above ;)

it's still in progress ;)
even in 2.6.18-rc there are semaphore to mutex conversions....
the remaining ones are increasingly tricky though so speed is slowing
down


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

