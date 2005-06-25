Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFYQtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFYQtN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 12:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFYQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 12:49:13 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20972 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261250AbVFYQtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 12:49:10 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Mahoney <jeffm@suse.de>,
       penberg@gmail.com, reiser@namesys.com, ak@suse.de, flx@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20050623193247.GC6814@suse.de>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	 <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>
	 <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
	 <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de>
	 <20050623114318.5ae13514.akpm@osdl.org>  <20050623193247.GC6814@suse.de>
Date: Sat, 25 Jun 2005 19:46:07 +0300
Message-Id: <1119717967.9392.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-06-23 at 21:32 +0200, Jens Axboe wrote:
> then it's impossible to know which one it is without the identical
> source at hand.

In which case, debugging is risky IMO (the source code could have
changed a lot).

On Thu, 2005-06-23 at 21:32 +0200, Jens Axboe wrote:
> That said, I don't like the reiser name-number style. If you must do
> something like this, mark responsibility by using a named identifier
> covering the layer in question instead.
> 
>         assert("trace_hash-89", is_hashed(foo) != 0);

A human readable message would be nicer. For example, "foo was hashed".

		Pekka

