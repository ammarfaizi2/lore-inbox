Return-Path: <linux-kernel-owner+w=401wt.eu-S1030277AbXAECU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbXAECU1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbXAECU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:20:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:35437 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030277AbXAECUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:20:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rFDYqZ5U+7B3rw89xWqVgU0LvCXqoh0uxUFLiK3I01P91DSGr03s4cSk2lJK3xi1Jf7h7+BFepkBHqk5oxol1AjDucna8qI/pIDCh+6x/CnHSRuPsJWFtpQwyZ5sElaY8HSy1zlrTcs9sPdJ2n8MoKZb+Igz89uIfJ6AutXcXOI=
Message-ID: <7ce7bf330701041820l5132ddbfsd3dd2b6ea826f3ae@mail.gmail.com>
Date: Fri, 5 Jan 2007 00:20:23 -0200
From: MoRpHeUz <morpheuz@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Cc: "Stelian Pop" <stelian@popies.net>, "Mattia Dongili" <malattia@linux.it>,
       "Len Brown" <lenb@kernel.org>, "Ismail Donmez" <ismail@pardus.org.tr>,
       "Andrea Gelmini" <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Cacy Rodney" <cacy-rodney-cacy@tlen.pl>
In-Reply-To: <20070104154434.7e1a7c83.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <1167953784.4901.5.camel@localhost.localdomain>
	 <20070104154434.7e1a7c83.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I own a Sony Vaio VGN-SZ340 and I had problems regarding acpi + it's
dual core processor. The guys from Intel gave me a workaround and now
it recognises both cores.

  The problem is that it does not do cpu frequency scaling for both
cores, just for cpu0...And when I boot with acpi the Nvidia graphic
card doesnt work also.

  I don't know if you know about these problems regarding sony acpi.
The guys from Intel said that this notebook have 2 dst's. So to detect
both cores the workaround just uses the second dst (although frequency
scaling does work for both.)

  I can help you to fix this bug...I have the machine where we can do
some tests..


Best regards,


On 1/4/07, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 05 Jan 2007 00:36:23 +0100
> Stelian Pop <stelian@popies.net> wrote:
>
> > Added acpi_bus_generate event for forwarding Fn-keys pressed to acpi subsystem,
> > and made correspondent necessary changes for this to work.
>
> neato.
>
> err, how does one use this?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
