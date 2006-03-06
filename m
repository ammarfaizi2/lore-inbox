Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWCFQUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWCFQUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWCFQUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:20:15 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:49489 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbWCFQUN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:20:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uXvOxrtWppiuJj9Mk7sCTtlpCUeVKrvb3zk281aGO/Py115gvr41FsrWSSgfHp8idOq8NXEu48ECxTzY/tLnwyvWCsD48MKNjuR7w2E2KigrKF5p0Fil1oLEQEflitmSDmws0dhrkZEi/gV1XYea3rvJpeNBITPewkiF1FMQXsI=
Message-ID: <9a8748490603060820l6bb23a7fna032b8f0a022c458@mail.gmail.com>
Date: Mon, 6 Mar 2006 17:20:12 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Olivier Galibert" <galibert@pobox.com>,
       "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Is that an acceptable interface change?
In-Reply-To: <20060306161512.GB23513@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306011757.GA21649@dspnet.fr.eu.org>
	 <1141631568.4084.2.camel@laptopd505.fenrus.org>
	 <20060306155021.GA23513@dspnet.fr.eu.org>
	 <9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
	 <20060306161512.GB23513@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Olivier Galibert <galibert@pobox.com> wrote:
> On Mon, Mar 06, 2006 at 04:55:02PM +0100, Jesper Juhl wrote:
> > Userspace apps should not include kernel headers, period.
> > So, userspace applications really shouldn't care.
>
> Please excuse me if I'm a little dense here, but the kernel headers
> _define_ the userspace-kernel interface.  If you don't have them or a
> sanitized copy of them you just can't talk with the kernel at all.
>

Well, stuff like glibc, the alsa lib etc are exceptions, but the
exceptions are few and far between.
Random userspace apps should not use the kernel headers directly, they
should instead talk to things like glibc and let glibc handle the
userspace<->kernel bit.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
