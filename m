Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVDTNgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVDTNgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 09:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVDTNgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 09:36:46 -0400
Received: from sanosuke.troilus.org ([66.92.173.88]:60365 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S261619AbVDTNgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 09:36:43 -0400
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL violation by CorAccess?
From: Michael Poole <mdpoole@troilus.org>
Date: Wed, 20 Apr 2005 09:36:41 -0400
In-Reply-To: <1114002429.774.45.camel@localhost.localdomain> (Steven
 Rostedt's message of "Wed, 20 Apr 2005 09:07:09 -0400")
Message-ID: <873btlwowm.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
References: <20050419175743.GA8339@beton.cybernet.src>
	<20050419182529.GT17865@csclub.uwaterloo.ca>
	<Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
	<42656319.6090703@nortel.com>
	<Pine.LNX.4.61.0504191741190.19956@chaos.analogic.com>
	<42659620.5050002@nortel.com> <1113982209.3803.7.camel@gimli.at.home>
	<1114001398.774.40.camel@localhost.localdomain>
	<1114001836.6238.68.camel@laptopd505.fenrus.org>
	<1114002429.774.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt writes:

> On Wed, 2005-04-20 at 14:57 +0200, Arjan van de Ven wrote:
>> On Wed, 2005-04-20 at 08:49 -0400, Steven Rostedt wrote:
>> > On Wed, 2005-04-20 at 09:30 +0200, Bernd Petrovitsch wrote:
>> > 
>> > > 
>> > > As long as they do not statically link against LGPL (or GPL) code and as
>> > > long as they do not link dynamically agaist GPL code. And there are
>> > > probably more rules .....
>> > > 
>> > 
>> > Actually, I believe that the LGPL allows for static linking as well.
>> 
>> it does, as long as you provide the .o files of your own stuff so that
>> the end user can relink with  say a bugfixed version of library.
>
> I don't see that in the license.  As point 5 showed: "Such a
> work, in isolation, is not a derivative work of the Library, and
> therefore falls outside the scope of this License."

"Such a work" refers to "A program that contains no derivative of any
portion of the library."  A program that is statically linked against
the library clearly contains part or all of the library, and cannot
qualify for the lower threshold of section 5.  Section 5 is talking
about late binding to the library; dynamic linking is one example.

For programs distributed as object code that does contain part of the
library, the distributor must -- sooner or later -- comply with 6(a)
(allow the user to relink) or 6(b) (use dynamic linking).

Michael Poole
