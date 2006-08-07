Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWHGV6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWHGV6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWHGV6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:58:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12050 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751122AbWHGV6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:58:02 -0400
Date: Mon, 7 Aug 2006 21:56:02 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Jeff Garzik <jeff@garzik.org>, David Masover <ninja@slaphack.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: ext3 vs reiserfs speed (was Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion))
Message-ID: <20060807215602.GA4540@ucw.cz>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com> <44CA98F9.1040900@garzik.org> <44CAD3FF.8060203@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CAD3FF.8060203@namesys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Using guilt as an argument in a technical discussion is a flashing red
> > sign that says "I have no technical rebuttal"
> 
> Wow, that is really nervy.  Let's recap this all:
> 
> * reiser4 has a 2x performance advantage over the next fastest FS
> (ext3), and when compression ships in a month that will double again as
> well as save space.  See http://www.namesys.com/benchmarks.html, and

Does that mean that ext3 is faster than reiser3? Wow, that would be
good reason to switch default filesystem to ext3 (or reiser4?) in next
suse release.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
