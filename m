Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUDEVee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbUDEVc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:32:26 -0400
Received: from web40512.mail.yahoo.com ([66.218.78.129]:17060 "HELO
	web40512.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263364AbUDEVa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:30:27 -0400
Message-ID: <20040405213026.37258.qmail@web40512.mail.yahoo.com>
Date: Mon, 5 Apr 2004 14:30:26 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Timothy Miller <miller@techsource.com>
Cc: John Stoffel <stoffel@lucent.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4071CF6E.4030104@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Timothy Miller <miller@techsource.com> wrote:
> 
> 
> Sergiy Lozovsky wrote:
> 
> > 
> > 
> > All LISP errors are incapsulated within LISP VM.
> >  
> 
> 
> A LISP VM is a big, giant, bloated.... *CHOKE*
> *COUGH* *SPUTTER* 
> *SUFFOCATE* ... thing which SHOULD NEVER be in the
> kernel.

It is a smallest interpreter (of all purpose language)
I was able to find. My guess is that you refer to the
Common Lisp. it is huge and I don't use it.

> 
> If you want to use a more abstract language for
> describing kernel 
> security policies, fine.  Just don't use LISP.

Point me to ANy langage with VM around 100K.

> The right way to do it is this:
> 
> - A user space interpreter reads text-based config
> files and converts 
> them into a compact, easy-to-interpret code used by
> the kernel.
> 
> - A VERY TINY kernel component is fed the security
> policy and executes it.

it is exactly the way it is implemented. Not everyone
need to create their own security model (that VERY
TINY kernel component you refer to). But even for
those who want to modify or create their own VERY TINY
kernel component - they don't need to do that in C and
debug it in th kernel crashing it.

> 
> Move as much of the processing as reasonable into
> user space.  It's 
> absolutely unnecessary to have the parser into the
> kernel, because 
> parsing of the config files is done only when the
> ASCII text version 
> changes.
> 
> It's absolutely unnecessary to have something as
> complex as LISP to 
> interpret it, when something simple and compact
> could do just as well.
> 
> Why do you choose LISP?  Don't you want to use a
> language that sysadmins 
> will actually KNOW?

It was is) the smallest VM I know of.

99% of sysadmins don't need to create their own
security models. Security polices are created with web
interface very close to the way you described. So
sysadmin don't need to know anything about LISP (to
use predefined security models).

Serge.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
