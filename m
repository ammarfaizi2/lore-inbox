Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265799AbRF3LIl>; Sat, 30 Jun 2001 07:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbRF3LIc>; Sat, 30 Jun 2001 07:08:32 -0400
Received: from phil.iph.to ([212.98.162.99]:54533 "EHLO iph.to")
	by vger.kernel.org with ESMTP id <S265799AbRF3LIU>;
	Sat, 30 Jun 2001 07:08:20 -0400
Message-ID: <3B3DB318.B799F4E3@iph.to>
Date: Sat, 30 Jun 2001 14:08:08 +0300
From: Philips <philips@iph.to>
Organization: Enformatica Ltd. UK
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: A Possible 2.5 Idea, maybe?
In-Reply-To: <Pine.LNX.4.33.0106290753340.25959-100000@biglinux.tccw.wku.edu> <20010629164942.B21707@crosswinds.net>
Content-Type: multipart/mixed;
 boundary="------------34C4F26D4A2631D11529CA82"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------34C4F26D4A2631D11529CA82
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

Patrick Mauritz wrote:
> 
> On Fri, Jun 29, 2001 at 08:17:25AM -0500, Brent D. Norris wrote:
> > Instead of forking the kernel or catering only to one group, instead why
> > not try this:  Using the new CML2 tools and rulesets, make it possible to
> > have the kernel configured for the type of job it will be doing?  Just
> > like CML2 asks our CPU type (i386, alpha, althon ...) and then goes out
> > and configures options for that, have it ask people "Is your machine a
> > server, workstation, embedded/handheld?" and configure things in the
> > kernel like the VM, bootup and others to optimize it for that job type?
> that could be the "easy == end-user" setup
> why can't there be two (possibly similar but tweaked) VMs (and other stuff as well)
> be in the source so everyone has to choose exactly one for his kernel?
> 

	there are patches for plug-able TCP/IP stacks.
	filesystems are already plug-able (someone need journaling, some one needs
quoatas, some needs nothing).
	there are patches for plug-able task scheduler.

	If I could choose what filesystem to run on / - it impact performance greatly
- why can't I choose how my tasks are scheduled? how my packets are going to
NIC?

	IMHO great idea. I think this will improve portability. And embeded guys will
be in permanent satisfaction ;-)


	But I'm afraid this won't happen in 2.5 - this kind of change require well
defined and stable internal interfaces. So this is really huge amount of work.
	This would be one little step toward the microkernel architecture (like Hurd).
Good again :-)
--------------34C4F26D4A2631D11529CA82
Content-Type: text/x-vcard; charset=koi8-r;
 name="philips.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Philips
Content-Disposition: attachment;
 filename="philips.vcf"

begin:vcard 
n:Filiapau;Ihar
tel;pager:+375 (0) 17 2850000#6683
tel;fax:+375 (0) 17 2841537
tel;home:+375 (0) 17 2118441
tel;work:+375 (0) 17 2841371
x-mozilla-html:TRUE
url:www.iph.to
org:Enformatica Ltd.;Linux Developement Department
adr:;;Kalinine str. 19-18;Minsk;BY;220012;Belarus
version:2.1
email;internet:philips@iph.to
title:Software Developer
note:(none)
x-mozilla-cpt:;18368
fn:Philips
end:vcard

--------------34C4F26D4A2631D11529CA82--

