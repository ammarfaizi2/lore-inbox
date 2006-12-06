Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937595AbWLFUKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937595AbWLFUKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937600AbWLFUKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:10:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:52087 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937595AbWLFUKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:10:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HJzpHS1Mogn0lHREC9OrWQcxDBMC+27HWIsZEqthIEa7ISMKtgLWLkkieXGWPbv2FWue1cbWrRcmuAysjRs5eD7UogLozKQ/Ruv8sAW8nwOb2b0c6YeYo0jbmwtElzZh45fbHVXliON3QSKLtC7ExwGUM/riOaCTNSocx32xtPk=
Message-ID: <a36005b50612061210q407ea90ew4a32328e65145bbf@mail.gmail.com>
Date: Wed, 6 Dec 2006 12:10:08 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux should define ENOTSUP
Cc: "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
       "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4576DF04.4000900@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206135134.GJ3927@implementation.labri.fr>
	 <1165415115.3233.449.camel@laptopd505.fenrus.org>
	 <20061206143159.GP3927@implementation.labri.fr>
	 <4576DF04.4000900@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, H. Peter Anvin <hpa@zytor.com> wrote:
> That's largely already the case, mostly because there is unfortunately
> still a fair bit of rubber-stamping Solaris going on.

Don't say that, Peter.

I'm working on the committee now for many years and got most changes I
(and those telling me their wishes) wanted through.  This is very much
a technically oriented working group, not political.  In fact, of the
regular members there are more with stakes in Linux than any of the
other OSes combined.  If there are problems people perceive they can
file bugs on the OpenGroup's site
(http://www.opengroup.org/austin/defectform.html) or tell me about it.

About the issue at hand: if the original poster would have taken the
time to investigate the issue he would have seen that this topic was
discussed (I think we handled it in September in Reading).  See

http://www.opengroup.org/austin/aardvark/latest/xbdbug2.txt

The statement about the interpretations track means that the change
will be made to the current standard, not only the next revision.

There is no need to change anything in kernel or libc.  Code using
both values in a switch statement is out of luck but a) this is really
really rare (nobody should reimplement strerror) and b) can be easily
fixed.
