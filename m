Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWA0ATQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWA0ATQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWA0ATQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:19:16 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:8325 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932362AbWA0ATP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:19:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iXhOogQSqngiCYnUCdUVU1MUHNT+wcLGccX0Z3zRXjzkTMZ8MUShXJJxAecHulEZ1ka65PEs3FGXWtSXdoKpRbaHxqEeYYnaK+iSgHTaUSrF7Jj+EY/VxvU2qrHHobajuZaXaFE0zMsd5ERY7+Lwl0D5W/lQ9zueQ8MGXUtYzg4=
Message-ID: <787b0d920601261619l43bb95f5k64ddd338f377e56a@mail.gmail.com>
Date: Thu, 26 Jan 2006 19:19:14 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <43D8D396.nailE2X31OHFU@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
	 <43D8D396.nailE2X31OHFU@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Albert Cahalan <acahalan@gmail.com> wrote:

> > You can't fool me, because I looked at the cdrecord source
> > code and at the documented APIs for various OSes.
>
> I am sorry to see that you did not look close enough...
...
> > Names can be handled by Windows, FreeBSD, MacOS X,
> > Linux, OpenBSD, Solaris, HP-UX, AIX, and IRIX.
> > That's everything that isn't end-of-lifed.

OK, this is getting silly and downright offensive. I encourage
everyone else to look over the code to see that I am right.

I may just be crazy enough to fork this project. I very nearly
did about 18 months ago. I can't very well do this alone,
because I don't have all the hardware. (It's either cdrecord
or Asterisk -- I'm not sure which one pisses me off the most)

Me:

* was an RTOS developer
* day job is all about secure software
* the procps maintainer
* running Linux 2.6.xx only
* using FireWire, which is totally hot-plug

Perhaps the first thing to do would be to find a list of all the
apps that depend on cdrecord. Their interface to cdrecord
needs to be documented so that a compatibility script can
be made.

Matthias, can you give me a hand with this? I'll need a way
to sort and publish incoming patches, letting them sit for a
while. (like what Andrew Morton does for the kernel) This
can't work like procps because the hardware varies too much.
