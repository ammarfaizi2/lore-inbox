Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264633AbSJ3J0K>; Wed, 30 Oct 2002 04:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264634AbSJ3J0K>; Wed, 30 Oct 2002 04:26:10 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:25500
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S264633AbSJ3J0I>; Wed, 30 Oct 2002 04:26:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Wed, 30 Oct 2002 04:32:23 -0500
User-Agent: KMail/1.4.2
Cc: Jeff Garzik <jgarzik@pobox.com>, landley@trommello.org,
       linux-kernel@vger.kernel.org, reiser@namesys.com,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com, boissiere@adiglobal.com
References: <200210272017.56147.landley@trommello.org> <200210300322.17933.dcinege@psychosis.com> <20021030083751.A25178@flint.arm.linux.org.uk>
In-Reply-To: <20021030083751.A25178@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300432.23107.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 3:37, Russell King wrote:
> On Wed, Oct 30, 2002 at 03:22:17AM -0500, Dave Cinege wrote:
> > Do you have any serious sysadmin, clustering, or emebedded system
> > IMPLEMENTATION experience?
>
> Please don't get personal, or you'll end up in peoples kill files.

It's not personal. He made a wild 'No one needs any of this[initrd]' 
statement. Is he coming from 'this looks like a good idea'(coder) or
'I can prove this is a good idea through experience examples.'
(systems engineer)

I can prove to you (for one thing) that when the shit hits the
fan (disaster recovery) initrd is a good option to have.

> ARM is basically embedded today, and I support initramfs.  I don't
> believe your "embedded system" argument holds any water.  Yes, it

High level embedded systems...low level systems could care less.

> is a different way of doing things, but it can (and does here)
> support initrd images.

The point to this is:

Linking an image into the kernel LOOKS nice, but I would sure not
want to deploy it because it becomes an adminstation nightmare. 
Even with initrd, a single file can be a problem...this is why my
patch supports extracting multiple tar.gz archives....to maintain
configuration modularity.

Having an image in the kernel is not a bad thing...making it the
only option is.

Dave

-- 
The time is now 22:48 (Totalitarian)  -  http://www.ccops.org/


