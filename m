Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132036AbQKKTUm>; Sat, 11 Nov 2000 14:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbQKKTUd>; Sat, 11 Nov 2000 14:20:33 -0500
Received: from limes.hometree.net ([194.231.17.49]:28974 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S132036AbQKKTU2>; Sat, 11 Nov 2000 14:20:28 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Nov 2000 19:12:14 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8uk5me$25a$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org>, <20001111111159.C9464@vger.timpanogas.org>
Reply-To: hps@tanstaafl.de
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@vger.timpanogas.org (Jeff V. Merkey) writes:

>I guess all customers are idiots then, since about 100+ people who were
>using our release downloaded it, and had these problems with sendmail.  This
>disconnect of yours is about what I would expect from someone in a University.
>Some of us don't have the luxury of being able to pontificate in a Univ
>environment -- we have to make a living from Linux -- and provide payroll
>for the people on this list who actually do the core work on Linux.  

I earn a living with building and deploying Internet system on a
variety of (Unix-based) platforms. Each one has its quirks and to
build successful servers, you have to know about them. I never ever
deployed a sendmail.cf as it came from the vendor or the source
package. I adjust these config files to the customers' need.

[...]

>somewhere not being deployed.  It's the commercialization effort that made
>Linux a household word.  NT and NetWare servers don't stop forwarding 

THERE IS NO SUCH EFFORT. This list is not your general-purpose Linux
support list.

If you need support for a distribution, get it from the vendor. If you
make a distribution, that deploys a software, give this support or buy
it from people who _know_ and sell it to your customers.

But this list is not for your "I don't have a clue" efforts. Deploying
a distribution is major grunt work that most customers will never see.

I e.g. deploy a highly customized version of RedHat on the servers
that I build. Most of my customers ask a second and a third time why I
don't simply deploy the distribution out of the box like all the
consultants that they had before. They stop asking when their old
boxes are cracked open or fail under load and mine doesn't. If you
deploy a general purpose distribution or OS for a very special
application, then you simply use the wrong tool.

>emails when the load average gets too high -- they just work out of the
>box, and hopefully, no so will Linux (our distribution does now since 
>this problem in fixed).

Your distribution will simply have "RefuseLA" and "QueueLA" higher
than the sendmail defaults. This is not the solution to your problem
but moves it simply to a different point.

You simply don't understand, that a cluster mail system that handles
20,000,000 mailboxes and 200,000,000 mails per day must be configured
different than the mail system on a high traffic web server, that
simply sends out two mails per day from the logfile rotation. Both
machines may have a load average way beyond a desktop system that
peaks at 0.05 on normal usage.

>Now we know that sendmail has problems on Linux based on the this load
>average interpretation, which we would not have known if someone had 
>not raised the issue.  

Linux has no problem. Some sites that run Linux have a problem because
they're misconfigured.

And if you ship a distribution but want to load off the support for
this distribution on Linux-Kernel, you're definitely in for a
surprise. TANSTAAFL, you know.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
