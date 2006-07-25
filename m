Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWGYFe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWGYFe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWGYFe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:34:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28035 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932474AbWGYFe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:34:56 -0400
Subject: Re: [patch] lockdep: annotate pktcdvd natural device hierarchy
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       petero2@telia.com, Laurent Riffard <laurent.riffard@free.fr>
In-Reply-To: <20060724192718.547a836e.akpm@osdl.org>
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	 <m3sllxtfbf.fsf@telia.com> <1151000451.3120.56.camel@laptopd505.fenrus.org>
	 <m3u05kqvla.fsf@telia.com> <1152884770.3159.37.camel@laptopd505.fenrus.org>
	 <m3odvrc2vo.fsf@telia.com> <1152947098.3114.9.camel@laptopd505.fenrus.org>
	 <44B8C506.1000009@free.fr> <m3ac7b6spp.fsf@telia.com>
	 <44BA1609.9050305@free.fr>  <20060724192718.547a836e.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 07:34:44 +0200
Message-Id: <1153805684.8932.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 19:27 -0700, Andrew Morton wrote:
> On Sun, 16 Jul 2006 12:33:45 +0200

> Arjan, do we still need
> lockdep-annotate-pktcdvd-natural-device-hierarchy.patch?

yes afaics

> And could you please take a look at Peter's block_dev.c changes?  Closely,
> please - it'd be nice to get this right one of these days ;)

I'm not too happy about them; they use the partition uglies for
something which is not a partition; the uglyness should stop not
spread... while the patch probably is effective in shutting lockdep up
it's not really the right approach.

Greetings,
   Arjan van de Ven


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

