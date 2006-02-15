Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWBOU2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWBOU2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWBOU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:28:12 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:18104 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932454AbWBOU2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:28:11 -0500
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43F37773.5030203@cfl.rr.com>
References: <m3lkwg4f25.fsf@telia.com>
	 <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
	 <43F0B8FC.6020605@cfl.rr.com>
	 <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
	 <43F1FD39.1040900@cfl.rr.com>
	 <84144f020602142331s756aff15o69d1d67f1b18127e@mail.gmail.com>
	 <43F34ED5.8020306@cfl.rr.com> <1140024709.24898.7.camel@localhost>
	 <43F37773.5030203@cfl.rr.com>
Date: Wed, 15 Feb 2006 22:28:02 +0200
Message-Id: <1140035282.3926.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 13:48 -0500, Phillip Susi wrote:
> True, that would work.  It would require the addition of another mount 
> option though, so I wonder, is that really needed?  What problem with 
> the current patch would this solve?  Is there really a need to save real 
> ids to the disk with the current uid option and no force?  Keep in mind 
> that udf is meant for removable media where the uids aren't going to 
> make any sense in another system.

Yeah, but even for removable media proper uid/gid makes sense. For
instance, if I am sharing an usb stick with someone else on the same
computer, uid/gid is useful. Anyway, I prefer that force thing and if
everyone else disagrees with me, now would be a good time to say so.

			Pekka

