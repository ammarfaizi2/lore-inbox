Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293507AbSCGXNc>; Thu, 7 Mar 2002 18:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310585AbSCGXNU>; Thu, 7 Mar 2002 18:13:20 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:16072 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293507AbSCGXNN>; Thu, 7 Mar 2002 18:13:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Guest section DW <dwguest@win.tue.nl>
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Date: Thu, 7 Mar 2002 18:14:10 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, rajancr@us.ibm.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com> <20020307190635.9DE533FE08@smtp.linux.ibm.com> <20020307194602.GA13092@win.tue.nl>
In-Reply-To: <20020307194602.GA13092@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307231307.D54F13FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 March 2002 02:46 pm, Guest section DW wrote:
> On Thu, Mar 07, 2002 at 02:07:38PM -0500, Hubertus Franke wrote:
> > On Thursday 07 March 2002 09:54 am, Guest section DW wrote:
> > > On Thu, Mar 07, 2002 at 09:35:09AM -0500, Hubertus Franke wrote:
> > > ...
> > >
> > > Long ago I submitted a patch that changed the max pid from 15 bits to
> > > 24 or 30 bits or so. (And of course removed the inefficiency noticed
> > > by some people in the current thread.)
> >
> > I don't think that will solve the N^2 problem
>
> Do you understand "inefficiency"? And "remove"?


I do, what's your point ?
I haven't seen your patch picked up....

I do understand that when you occasionally get into this scenario
of the loop that particularly for large thread counts this stalls the system
for seconds (say 30, with the tasklock held).


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
