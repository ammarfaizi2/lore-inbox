Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTJUMof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTJUMof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:44:35 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:47264 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S263076AbTJUMoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:44:34 -0400
Date: Tue, 21 Oct 2003 14:44:20 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: hunold@convergence.de, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proposal to remove workqueue usage from request_firmware_async()
Message-ID: <20031021124420.GA19308@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20031020235355.GA3068@ranty.pantax.net> <20031020170804.2117d9ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020170804.2117d9ca.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 05:08:04PM -0700, Andrew Morton wrote:
> Manuel Estrada Sainz <ranty@debian.org> wrote:
> >
> >  How does this look?
> 
> OK I guess.  I assume it works?

 Yes, it works. Although I didn't do heavy testing and it is the first
 time I play with kernel threads durectly, so I may be doing something
 stupid.
 
> > +	daemonize("%s/%s", "firmware", fw_work->name);
> 
> 	daemonize("firmware/%s", "fw_work->name);

 Dumb me, I'll resend with that.

 Regards

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
