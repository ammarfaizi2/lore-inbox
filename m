Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310533AbSCLJrO>; Tue, 12 Mar 2002 04:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310534AbSCLJqz>; Tue, 12 Mar 2002 04:46:55 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:41705 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S310533AbSCLJqy>; Tue, 12 Mar 2002 04:46:54 -0500
Date: Tue, 12 Mar 2002 11:46:42 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: zlib vulnerability and modutils
Message-ID: <20020312094642.GD128921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020311234516.GC128921@niksula.cs.hut.fi> <4394.1015887380@kao2.melbourne.sgi.com> <14719.1015891493@redhat.com> <20020312000828.GB132950@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312000828.GB132950@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 02:08:28AM +0200, you [Ville Herva] wrote:
> >
> > It may be a little more intrusive than you wanted though.
> 
> Quite possibly -- at least considering that some of the kernels I run are
> still 2.2.x and even 2.0.x...

I suppose this patch

http://cvs.samba.org/cgi-bin/cvsweb/rsync/zlib/infblock.c.diff?r1=text&tr1=1.2&r2=text&tr2=1.6&f=u

i closer to what I need. It seems most vendors have only patched ppp's zlib
implementation (drivers/net/zlib.c). I couldn't find that particular patch
in redhat update kernel .src.rpm, tough. I guess I'll have to apply the zlib
diff by hand.


-- v --

v@iki.fi
