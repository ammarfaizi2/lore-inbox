Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWBUWRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWBUWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWBUWRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:17:16 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:55315 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932566AbWBUWRO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:17:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SYsfnAHEGx5Z8Sn6O0syksPXuUXZs+Vqz3ZSmhWeDIJLqaa8QnZSnNp2payGTpV4iIZy2buIQScpnqr/PEDST9gDs+TRxBWDFJqzry2jRzeY5XrpXO7DbwLgl88ugTRlV0w402a09PrkR8RHX2GamCGMBeYl0k46ZDRaDnuTEdk=
Message-ID: <d120d5000602211417se24ed51w15e0c5c95b69d58c@mail.gmail.com>
Date: Tue, 21 Feb 2006 17:17:06 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
Cc: "Olivier Galibert" <galibert@pobox.com>, "Pavel Machek" <pavel@suse.cz>,
       "Nigel Cunningham" <nigel@suspend2.net>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>, rjw@sisk.pl
In-Reply-To: <1140559365.2742.80.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602200709.17955.nigel@suspend2.net>
	 <20060219234212.GA1762@elf.ucw.cz>
	 <200602201210.58362.nigel@suspend2.net>
	 <20060220124937.GB16165@elf.ucw.cz>
	 <20060220170537.GB33155@dspnet.fr.eu.org>
	 <1140559365.2742.80.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-02-20 at 18:05 +0100, Olivier Galibert wrote:
> > Pavel, if you mean that the userspace code will not be reviewed to
> > standards the kernel code is, kill uswsusp _NOW_ before it does too
> > much damage.  Unreliable suspend eats filesystems for breakfast.  The
> > other userspace components of the kernels services are either optional
> > (udev) or not that important (alsa).
> >
>
> Why is sound less important than suspending, or networking, or any other
> subsystem?  This is an insult to everyone who worked long and hard to
> get decent sound support on Linux.
>

I bet this was not meant as an insult. Quote: "Unreliable suspend eats
filesystems for breakfast". The worst thing mismatched ALSA library
could cause is noice in my speakers.

--
Dmitry
