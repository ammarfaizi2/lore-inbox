Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWE0KrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWE0KrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 06:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWE0KrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 06:47:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:20496 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751429AbWE0KrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 06:47:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IVztFFp0YPBcSYQN4TOgJabdPPxU7R6d6LALZVk5DcAfDifLmSxQ+T7vO5qvUEuVJjMBW0d9zczRRs5lv1lwpSUmSvLi4YNSununQ3r1icJ7ERqXxOLIHmnceGFicdpnixBWgwNAFoVjLAjQCNB+CrwWez1031XrAFwEyAIrxqI=
Message-ID: <9a8748490605270347h78f975e8xb022adeef54cfb70@mail.gmail.com>
Date: Sat, 27 May 2006 12:47:10 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: How to check if kernel sources are installed on a system?
Cc: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>, "Dave Jones" <davej@redhat.com>,
       linux-kernel@vger.kernel.org, "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <Pine.LNX.4.61.0605261058430.6879@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e55715+usls@eGroups.com> <447622EA.90704@garzik.org>
	 <20060525213952.GT13513@lug-owl.de> <20060525214413.GE4328@redhat.com>
	 <20060526143718.GY13513@lug-owl.de>
	 <Pine.LNX.4.61.0605261058430.6879@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Fri, 26 May 2006, Jan-Benedict Glaw wrote:
>
> > On Thu, 2006-05-25 17:44:13 -0400, Dave Jones <davej@redhat.com> wrote:
> >> On Thu, May 25, 2006 at 11:39:52PM +0200, Jan-Benedict Glaw wrote:
> >> > On Thu, 2006-05-25 17:34:34 -0400, Jeff Garzik <jeff@garzik.org> wrote:
> >> >>
> >> >> find / -name libata-scsi.c
> >> >
> >> > Which of the 10 versions showing up is the "right" one?
> >>
> >> For the sake of compiling out-of-tree modules, it's also useless,
> >> as sanitised headers (like Fedora's kernel-devel package) won't have this.
> >>
> >> Following /lib/modules/`uname -r`/build is the only way this can work.
> >> (And that should be true on any distro)
> >
> > As long as you actually compile the modules on the machine they're
> > ment to run on...
> >
> > MfG, JBG
>
> Distributions really need to have been built on the target system
> so that the CONFIG variables are correct and the various dynamic
> files have been created. Therefore I suggest that the presence of:
>
>         /usr/src/linux-`uname -r`/System.map
>
> ... is probably good enough for most everyone.
>

Assuming you build your kernels in /usr/src/ - many people don't, me included.
My kernels are all build in /home/juhl/download/kernel/linux-<version>/

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
