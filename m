Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbULPWvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbULPWvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbULPWtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:49:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51416 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262053AbULPWpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:45:34 -0500
Date: Thu, 16 Dec 2004 14:45:31 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: debugfs in the namespace
Message-ID: <20041216144531.3a8d988c@lembas.zaitcev.lan>
In-Reply-To: <20041216221843.GA10172@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
	<20041216190835.GE5654@kroah.com>
	<41C20356.4010900@sun.com>
	<20041216221843.GA10172@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 14:18:43 -0800, Greg KH <greg@kroah.com> wrote:

> Hm, what about /.debug ?  That's a compromise that I can live with (even
> less key strokes to get to...)

No way, Jan is out of his mind, adding obfuscations like that. Anything
but that. I didn't even bother to reply, because it never occurred to me
that you'd fall for something so retarded.

Otherwise, /dbg sounds good.

Mike's objections sound philosophically congenial to me. What I'm trying
to have here is to support an equivalent of tcpdump, which some may consider
a core function rather than a debugging function. Of course, I could easily
say "this is for debugging only" and thus deflect Mike, but this is not
about winning, and actually I have no investment in any approach. For me the
/sys is obviously out because of the "one file one value" doctrine. The /proc
sounds attractive, but programming procfs is such a bother. If we had a debugfs
style API to procfs, that would be the winner from the standpoint of this
application. Failing that, I guess, it's /dbg.

-- Pete
