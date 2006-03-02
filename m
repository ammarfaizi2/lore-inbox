Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWCBCU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWCBCU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWCBCU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:20:26 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:10466 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751392AbWCBCUZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:20:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+xexSKkRJgJZYDTy8wBW1mL9vWHrGBiSy/MixHHjlqP1fox5/60I4c9T/Bh4L1l7VFt/Y10gUm+UOAJmZjk2LEqeH2awOIvIKJ+Otgu9FMCuyaQCFIASEhfJvFR2hkGesI7Dsg9HHu/CwCu4o+ADaAy1SM0A70ZNsN3IQUhKPo=
Message-ID: <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
Date: Wed, 1 Mar 2006 19:20:22 -0700
From: "Eric D. Mudama" <edmudama@gmail.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Cc: "Jens Axboe" <axboe@suse.de>, "Tejun Heo" <htejun@gmail.com>,
       "Nicolas Mailhot" <nicolas.mailhot@gmail.com>,
       "Mark Lord" <liml@rtr.ca>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
In-Reply-To: <4406512A.9080708@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <4405F471.8000602@rtr.ca>
	 <1141254762.11543.10.camel@rousalka.dyndns.org>
	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> This also begs the question... what controller was being used, when the
> single Maxtor device listed in the blacklist was added?  Perhaps it was
> a problem with the controller, not the device.
>
>         Jeff

As reported here:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951

the controller was a 3114, and the bug was "fixed" by blacklisting his
Maxtor drive's FUA support.  I'd like Maxtor drives to be
un-blacklisted if possible.

--eric
