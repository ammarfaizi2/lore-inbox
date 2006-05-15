Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWEOOBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWEOOBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWEOOBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:01:09 -0400
Received: from [202.125.80.34] ([202.125.80.34]:53043 "EHLO
	esnmail.esntechnologies.co.in") by vger.kernel.org with ESMTP
	id S964918AbWEOOBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:01:07 -0400
Content-class: urn:content-classes:message
Subject: RE: GPL and NON GPL version modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 May 2006 19:30:55 +0530
Message-ID: <AF63F67E8D577C4390B25443CBE3B9F709295D@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GPL and NON GPL version modules
thread-index: AcZ4Jl2xNnwHRATDSYS20W2rq1OVawAALveg
From: "Nutan C." <nutanc@esntechnologies.co.in>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>,
       "Fawad Lateef" <fawadlateef@gmail.com>, <jjoy@novell.com>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, <gauravd.chd@gmail.com>,
       <bulb@ucw.cz>, <greg@kroah.com>, "Shakthi Kannan" <cyborg4k@yahoo.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I said, I haven't started any development and wouldn't want to
proceed unless and until I am sure of not violating GPL. I am working on
a proprietary OS and I have a module which can talk to the OS through
remote mechanism. However, since the interface is susceptible to be used
by other OS as well, I wanted to make sure of it. I am not an expert in
Linux. And, that's the reason; I am seeking your opinion, so that I
don't falter at a later stage.

Regards,
Nutan 

-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: Monday, May 15, 2006 7:19 PM
To: Nutan C.
Cc: Jan Engelhardt; linux-kernel-Mailing-list; Fawad Lateef;
jjoy@novell.com; Mukund JB.; gauravd.chd@gmail.com; bulb@ucw.cz;
greg@kroah.com; Shakthi Kannan; Srinivas G.
Subject: RE: GPL and NON GPL version modules


On Mon, 15 May 2006, Steven Rostedt wrote:

>
> On Mon, 15 May 2006, Nutan C. wrote:
>
> > Ok, so now, I have a new doubt :-) Forgive me, if I am asking a lot,
but
> > I really don't want to move ahead with the development, until and
unless
> > I am sure I am not violating GPL. So, please bear with me. Here's
the
> > question:
> >
> > 1. I developed a code which interfaces well with a proprietary OS.
Now,
> > somebody else feels to use the same module in his Linux Kernel. So,
he
> > comes up with a patch, which interfaces and talks to my module with
my
> > interfaces and then makes a release with the patch. And, I would
have no
> > idea of my module being really compatible/used in Linux Kernel. One
fine
> > day, I would get a mail saying that I need to make my code open
source.
> > What would be my reply?
> >
>
> Big fat answer is No!  You are not distributing GPL code.  Just
because
> someone made GPL code that interacts with your module, doesn't make
you
> responsible for it. (OK now for a IANAL disclaimer)  I'm not a lawyer,
but
> I would bet my career on this one (at least in the US).
>
> You cant be held responsible for someone else's actions.
>
> So your reply is simple:
>
> I'm sorry, but I don't distribute GPL code, please see your
distributor.


One more note.  The person that distributed the GPL code with your
module
may be the one in the "grey area". But then again, how can your module
be
a derived work if the author didn't even intend on having it work with
Linux?

-- Steve

