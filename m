Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUKXMVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUKXMVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 07:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUKXMVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 07:21:10 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:41600 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262625AbUKXMVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 07:21:06 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 24 Nov 2004 13:11:49 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Gerd Knorr <kraxel@suse.de>, Johannes Stezenbach <js@convergence.de>,
       Johannes Stezenbach <js@linuxtv.org>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041124121148.GD22798@bytesex>
References: <20041122102502.GF29305@bytesex> <20041122141607.GA21184@linuxtv.org> <20041122144432.GB575@bytesex> <20041122153637.GA10673@convergence.de> <20041122165201.GA2060@bytesex> <1101272551.6186.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101272551.6186.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 04:02:31PM +1100, Rusty Russell wrote:
> On Mon, 2004-11-22 at 17:52 +0100, Gerd Knorr wrote:
> > > Delaying request_module() sounds ugly. Anyway, if you can
> > > get it to work reliably...
> > 
> > I think I can, havn't tried yet through.
> 
> I still don't really like it as a solution,

I don't either, but loading modules unconditionally even if not needed
(especially if they pull in the complete dvb subsystem) isn't very nice
as well.

I'm open to other suggestions ...

> but this patch (pending anyway) should help.

Thanks.

  Gerd

