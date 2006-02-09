Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWBIJWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWBIJWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWBIJWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:22:04 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:4553 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1030309AbWBIJWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:22:03 -0500
Date: Thu, 9 Feb 2006 10:21:43 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH GIT] drivers/block/ub.c - misc. cleanup/indentation, removed unneeded return
Message-ID: <20060209092143.GA5676@stiffy.osknowledge.org>
References: <mailman.1139418724.17734.linux-kernel2news@redhat.com> <20060208194057.55b02719.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208194057.55b02719.zaitcev@redhat.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g0bdd340c-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pete Zaitcev <zaitcev@redhat.com> [2006-02-08 19:40:57 -0800]:

> On Wed, 8 Feb 2006 10:29:15 +0100, Marc Koschewski <marc@osknowledge.org> wrote:
> 
> > I created this little patch while reading through drivers/block/ub.c. It fixes
> > some indentation/whitespace as well as some empty commenting, an hardcoded
> > module name and an unneeded return.
> 
> I strongly disagree.

OK.

> 
> The only segment which has some merit is the one which replaces the .name
> with DRV_NAME. It could have been "usb-block" or something, but we probably
> won't be using that, so it's all right.

I just dislike using the same values twice and not using constants. More of a
personal thing I guess.

> 
> But the rest is quite bad, the worst being indenting the switch statement.

I see. Why do you use if-statement-indenting then?

What is the sense of the empty comments? What sense does the 'immediate
return' make when the value is returned 2 lines below (where one line is just
a closing brace)?

> 
> Is there nothing else you can do in the whole kernel?

Sure, but I guess you don't have to tell me what files I put my nose in, do
you? I didn't mean to personally piss you off by sending this in. Tzzz ...

Unfortunately my understanding of how ie. the Linux VM works is not very good.
In fact it's poor. But I will dig into this and try to make even you happy with
a patch that makes sense _in your eyes_.

> 
> -- Pete
> 

Marc
