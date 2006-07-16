Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWGPQtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWGPQtR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWGPQtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:49:16 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:17956 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751149AbWGPQtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:49:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FqgaaqWckPv74wIPX4YTijviGS7FN9cqE5DbXzMiYooz4iJ7kmtkGlFJ2hvQwQwkmqwfXJqrVIWISBCbhY1luEJG6J+UItT01wso4+sNWVZKnfiXQTfhW4/WRvXEhRxaEc0e4uxgt9nXmYT12guVu13BIXSq0HvLtv7qGux0ZIc=
Message-ID: <6bffcb0e0607160949j7b38c98ci323c62d9b35e469a@mail.gmail.com>
Date: Sun, 16 Jul 2006 18:49:15 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: 2.6.17.3 kernel panic
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3lkqta4h9.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m3psg5a5lp.fsf@defiant.localdomain>
	 <6bffcb0e0607160926h25ae8171kf2785f731a62fb6b@mail.gmail.com>
	 <m3lkqta4h9.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> writes:
>
> >> c010ae3d T do_page_fault
> >> c010b368 t .text.lock.fault
> > [snip]
> >>
> >> What could it be?
> >> How could I debug it?
> >
> > please try
> > gdb vmlinux
> > list *0xc010b247
>
> I actually included listing of the code fragment in question (both
> assembly and C).

Ah, yes I see. Sorry for the noise.

Have you tried memtest86+ (http://www.memtest.org/)?

> --
> Krzysztof Halasa
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
