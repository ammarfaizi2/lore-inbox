Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbULPXCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbULPXCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbULPW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:59:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:13242 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262126AbULPWxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:53:37 -0500
Date: Thu, 16 Dec 2004 14:53:23 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>, linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041216225323.GA10616@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com> <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com> <20041216144531.3a8d988c@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216144531.3a8d988c@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 02:45:31PM -0800, Pete Zaitcev wrote:
> On Thu, 16 Dec 2004 14:18:43 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > Hm, what about /.debug ?  That's a compromise that I can live with (even
> > less key strokes to get to...)
> 
> No way, Jan is out of his mind, adding obfuscations like that. Anything
> but that. I didn't even bother to reply, because it never occurred to me
> that you'd fall for something so retarded.

Bah, fine :)

> Otherwise, /dbg sounds good.

Ok, I can live with that.

> Mike's objections sound philosophically congenial to me. What I'm trying
> to have here is to support an equivalent of tcpdump, which some may consider
> a core function rather than a debugging function. Of course, I could easily
> say "this is for debugging only" and thus deflect Mike, but this is not
> about winning, and actually I have no investment in any approach. For me the
> /sys is obviously out because of the "one file one value" doctrine. The /proc
> sounds attractive, but programming procfs is such a bother. If we had a debugfs
> style API to procfs, that would be the winner from the standpoint of this
> application. Failing that, I guess, it's /dbg.

Yes, usb data dumping could go in /dbg, it makes sense.

thanks,

greg k-h
