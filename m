Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVIGLG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVIGLG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVIGLG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:06:27 -0400
Received: from port-212-202-160-2.static.qsc.de ([212.202.160.2]:29448 "EHLO
	imr-mail.intra.in-medias-res.com") by vger.kernel.org with ESMTP
	id S932109AbVIGLG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:06:26 -0400
Message-ID: <431ECA16.8040104@in-medias-res.com>
Date: Wed, 07 Sep 2005 13:08:06 +0200
From: =?ISO-8859-15?Q?sch=F6nfeld_/_in-medias-res?= 
	<schoenfeld@in-medias-res.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
References: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>
In-Reply-To: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>
X-Enigmail-Version: 0.92.0.0
X-SA-Exim-Connect-IP: 192.168.2.172
X-SA-Exim-Mail-From: schoenfeld@in-medias-res.com
Subject: ncpfs: Connection invalid / Input-/Output Errors
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Bogosity: No, tests=bogofilter, spamicity=0.496444, version=0.92.1
   int  cnt   prob  spamicity histogram
  0.00   12 0.022476 0.016007 ############
  0.10    0 0.000000 0.016007 
  0.20    0 0.000000 0.016007 
  0.30    0 0.000000 0.016007 
  0.40    0 0.000000 0.016007 
  0.50    0 0.000000 0.016007 
  0.60    0 0.000000 0.016007 
  0.70    0 0.000000 0.016007 
  0.80    0 0.000000 0.016007 
  0.90    6 0.992533 0.461789 ######
X-SA-Exim-Version: 4.0 (built Mon, 19 Jul 2004 17:01:11 +0200)
X-SA-Exim-Scanned: Yes (on imr-mail.intra.in-medias-res.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first of all: I'm unsure if i'm writing to the right list, so if i'm
wrong please just correct me.

At one of our sites we run a Novell Fileserver with some DOS Clients
and a linux server. The linux server is running an older SuSE version
with Linux 2.4.29 kernel, as well as various custom applications.
It is running quiet stable so far without bigger problems.

As we want to migrate our servers to Debian their is another system
running Debian, a Linux 2.6.12 kernel build from debianized sources and
the same custom applications as on the SuSE system. But for a reason,
we can't figure out, the novell connection on that system fails in
a random matter. It just "disappears" and logfiles (syslog and kern.log)
state that the ncpfs connection is invalid. First we thought of a
hardware problem, but that does not seem to be the reason, as we swapped
the responsible NIC and the problem keeps happening. Then we thought
it may be a kernel bug, which is maybe fixed in a newer version,
upgraded the kernel, but the situation did not change. I thought one
special application may be the point of failure, but it does run on
the other host, too - without any problem. Anyways i straced the
application to see whats happening when the connection breaks. Nothing,
that could help. It's just normal operation until it gets into an
"Input/Output Error" loop.

At the current point i don't know what to do. I don't see possibilites
to trace down the problem, nor can i find some hints via google or in
this mailinglist so i want to ask if somebody can tell me how to trace
down that problem, or give me some hints in any other way.

The ncpfs software running on the server is 2.2.6, while the server
without problems is running 2.2.0.18.

Thanks in advance

Greets
Patrick Schönfeld

IN MEDIAS RES
-=Operations=-
