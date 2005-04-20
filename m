Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVDTNHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVDTNHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 09:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVDTNHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 09:07:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44536 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261600AbVDTNHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 09:07:48 -0400
Subject: Re: GPL violation by CorAccess?
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>, linux-kernel@vger.kernel.org,
       Karel Kulhavy <clock@twibright.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-os@analogic.com,
       Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <1114001836.6238.68.camel@laptopd505.fenrus.org>
References: <20050419175743.GA8339@beton.cybernet.src>
	 <20050419182529.GT17865@csclub.uwaterloo.ca>
	 <Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
	 <42656319.6090703@nortel.com>
	 <Pine.LNX.4.61.0504191741190.19956@chaos.analogic.com>
	 <42659620.5050002@nortel.com>  <1113982209.3803.7.camel@gimli.at.home>
	 <1114001398.774.40.camel@localhost.localdomain>
	 <1114001836.6238.68.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 20 Apr 2005 09:07:09 -0400
Message-Id: <1114002429.774.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 14:57 +0200, Arjan van de Ven wrote:
> On Wed, 2005-04-20 at 08:49 -0400, Steven Rostedt wrote:
> > On Wed, 2005-04-20 at 09:30 +0200, Bernd Petrovitsch wrote:
> > 
> > > 
> > > As long as they do not statically link against LGPL (or GPL) code and as
> > > long as they do not link dynamically agaist GPL code. And there are
> > > probably more rules .....
> > > 
> > 
> > Actually, I believe that the LGPL allows for static linking as well.
> 
> it does, as long as you provide the .o files of your own stuff so that
> the end user can relink with  say a bugfixed version of library.

I don't see that in the license.  As point 5 showed: "Such a
work, in isolation, is not a derivative work of the Library, and
therefore falls outside the scope of this License." So you don't need to
do anything more than supply the source of the LPGL work. In fact, it
may not be a good idea to add a bugfixed version of the libary without
going through the vendor. You don't know if the application that uses
this depends on the side effects of the bug.

-- Steve


