Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSGESmm>; Fri, 5 Jul 2002 14:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSGESml>; Fri, 5 Jul 2002 14:42:41 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:16004 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317536AbSGESml>; Fri, 5 Jul 2002 14:42:41 -0400
Date: Fri, 5 Jul 2002 21:45:03 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: prevent breaking a chroot() jail?
Message-ID: <20020705184503.GQ1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <1025877004.11004.59.camel@zaphod> <ag4nob$sgq$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag4nob$sgq$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2002 at 11:15:39AM -0700, you [H. Peter Anvin] wrote:
> 
> This sounds like a job for [dum de dum dum] capabilities... remember,
> on Linux root hasn't been almighty for a very long time, it's just a
> matter of which capabilities you retain.  Of course, if you really
> want to be safe, you might end up with a rather castrated root inside
> the chroot shell.
> 
> If you really want to jail something, use UML.

ISTR UML had some security problems (guest processes being able to disrupt
host processes or just guest processes being able to disrupt other guest
processes). Have those been resolved yet? 

Do people use it in production? Last I heard someone had evaluated it, it
had ended up consuming way too much CPU per "jail" for whatever reason.
Perhaps things are better already...


-- v --

v@iki.fi
