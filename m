Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281952AbRKZRll>; Mon, 26 Nov 2001 12:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281951AbRKZRlb>; Mon, 26 Nov 2001 12:41:31 -0500
Received: from [208.48.139.185] ([208.48.139.185]:49566 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S281952AbRKZRlR>; Mon, 26 Nov 2001 12:41:17 -0500
Date: Mon, 26 Nov 2001 09:41:10 -0800
From: David Rees <dbr@greenhydrant.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Message-ID: <20011126094110.B7703@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Nov 26, 2001 at 01:54:11PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 01:54:11PM -0200, Marcelo Tosatti wrote:
> 
> > I like the ISC's release methods.  The do -rc's (-pre's would be fine
> > for the kernel as it is already established), each -rc fixes problems
> > found with the previous.  When an -rc has been out long enough with no
> > more bug reports they release that code, WITHOUT changes.
> 
> Thats exactly the idea with the "pre-final" thingie. 

Most groups use -rc release candidate releases, so using that instead of
-pre-final would lead to the least confusion.

A 2.4.17 release might look like this:

Release 2.4.17-preX until all the new stuff you want is in.
Release 2.4.17-rcX until no-one complains about the new stuff.
Release the last 2.4.17-rcX as 2.4.17 and hope no one finds anything
embarassing (which will probably happen anyway.

Seems to me though, that you can simply put a note in your Changelog which
-pre releases are bound to be to the next final revision, this will save us
from yet another numbering scheme.

-Dave
