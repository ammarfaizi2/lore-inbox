Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272844AbTHEPxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272843AbTHEPxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:53:15 -0400
Received: from www.13thfloor.at ([212.16.59.250]:8858 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272842AbTHEPxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:53:10 -0400
Date: Tue, 5 Aug 2003 17:53:20 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030805155320.GA8955@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Jesse Pollard <jesse@cats-chateau.net>, aebr@win.tue.nl,
	linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080416092800.04444@tabby> <20030805003210.2c7f75f6.skraw@ithnet.com> <03080509123100.05972@tabby> <20030805162152.2975dc33.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030805162152.2975dc33.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 04:21:52PM +0200, Stephan von Krawczynski wrote:
> On Tue, 5 Aug 2003 09:12:31 -0500
> Jesse Pollard <jesse@cats-chateau.net> wrote:
> 
> > > If you can do the fs patch, I can do the tar patch.
> > 
> > The patch is FAR too extensive. It would have to be a whole new filesystem
> 
> Fine. This is a clear and straight forward word. Can you explain why I don't
> see the mount -bind/rbind stuff through nfs? Is this a problem with a cheaper
> solution?

probably because --bind mounts have a vfsmount of their
own, and you do not explicitely export this submount?

just an idea,
Herbert

> Regards,
> Stephan
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
