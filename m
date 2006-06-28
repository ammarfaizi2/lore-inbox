Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932815AbWF1OnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbWF1OnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbWF1Om7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:42:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38233 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932815AbWF1Om6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:42:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sXlUYWMhauIqXZkejz6jc2S4m56o9Dn4KSJ1VOQyZgJ3kxujkqMmrloft0bOz221Hi1nnEmTP1K6qReDvyWKzEnds1zTdxloh4uXqjpi9YcUj6IJmqXyznpt7ZmZ2QtfURMuzAxPrypppkPCif6FkXordfiBymAyPaLB1oey3AI=
Message-ID: <84144f020606280742v348bdf53w96bd790362abaff9@mail.gmail.com>
Date: Wed, 28 Jun 2006 17:42:56 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Cc: "Rahul Karnik" <rahul@genebrew.com>, "Jens Axboe" <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <200606282242.26072.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
	 <200606271739.13453.nigel@suspend2.net>
	 <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com>
	 <200606282242.26072.nigel@suspend2.net>
X-Google-Sender-Auth: fb21b7403b78dcbf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On 6/28/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> It's because it's all so interconnected. Adding the modular infrastructure is
> useless without something to use the modules. Changing to use the pageflags
> functionality requires modifications in both the preparation of the image and
> in the I/O. There are bits that could be done incrementally, but they're
> minor. I did start with the same codebase that Pavel forked, but then did
> substantial rewrites in going from the betas to 1.0 and to 2.0.

Hmm, so, if you leave out the controversial in-kernel stuff like, user
interface bits, "extensible API", compression, and crypto, are you
saying there's nothing in suspend2 that can be merged separately?

                                        Pekka
