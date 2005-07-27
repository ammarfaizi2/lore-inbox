Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVG0BvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVG0BvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVG0BvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:51:03 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24036 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262346AbVG0BvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:51:01 -0400
Subject: Re: Question re the dot releases such as 2.6.12.3
From: Steven Rostedt <rostedt@goodmis.org>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: webmaster@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050727012853.GA2354@kurtwerks.com>
References: <200507251020.08894.gene.heskett@verizon.net>
	 <42E51593.7070902@didntduck.org>  <20050727012853.GA2354@kurtwerks.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 26 Jul 2005 21:50:50 -0400
Message-Id: <1122429050.29823.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 21:28 -0400, Kurt Wall wrote:
> On Mon, Jul 25, 2005 at 12:38:43PM -0400, Brian Gerst took 21 lines to write:
> > Gene Heskett wrote:
> > >Greetings;
> > >
> > >I just built what I thought was 2.6.12.3, but my script got a tummy 
> > >ache because I didn't check the Makefile's EXTRA_VERSION, which was 
> > >set to .2 in the .2 patch.  Now my 2.6.12 modules will need a refresh 
> > >build. :(
> > >
> > >So whats the proper patching sequence to build a 2.6.12.3?
> > >
> > 
> > The dot-release patches are not incremental.  You apply each one to the 
> > base 2.6.12 tree.
> 
> This bit me a while back, too. I'll submit a patch to the top-level
> README to spell it out.

Someone should also fix the home page of kernel.org. Since there's no
link on that page that points to the full 2.6.12. Since a lot of the
patches on that page go directly against the 2.6.12 kernel and not
2.6.12.3, it would be nice to get the full source of that kernel from
the home page.

If I want to incremently build the 2.6.13-rc3-mm1, would I need to
download the 2.6.12 tar ball, followed by the 2.6.13-rc3 patch and then
the 2.6.13-rc3-mm1 patch and apply them that way?  If so, I can get all
the patches but the starting point.  Yes I could also download the full
version of any of these, but it still seems to make sense to include the
starting point of the patches on the home page.

Just a thought,

-- Steve


