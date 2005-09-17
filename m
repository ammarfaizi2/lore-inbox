Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVIQFQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVIQFQl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 01:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVIQFQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 01:16:41 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:63291 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750921AbVIQFQk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 01:16:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aD8kehCXy/+QRAYHyT9do2yL0QVFhBpR8sdMQYvorz8cIOTo7A7LAF9ZyUtXdxHmFtsJoIdYODG6bGcPUPbJDRS9WtWRPeihBuOlK1ZvrfokOux9aXkBXtN2QqWQbfTKjT21K+GeUQfkxDAq34GZr4D6xSTMpD0lEPI5we9gXRI=
Message-ID: <4746469c05091622163e81dbea@mail.gmail.com>
Date: Fri, 16 Sep 2005 22:16:33 -0700
From: Mike Mohr <akihana@gmail.com>
Reply-To: akihana@gmail.com
To: michal@harddata.com, linux-kernel@vger.kernel.org
Subject: Re: Reboot & ACPI suspend Laptop display initialization
In-Reply-To: <20050916201457.GA29516@ellpspace.math.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4746469c0509161157bc762bc@mail.gmail.com>
	 <20050916201457.GA29516@ellpspace.math.ualberta.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't just a problem with ACPI's suspend.  If I reboot the
machine, without without power management, the screen isn't properly
reinitialized.  The problem with the suspend is certainly an issue
with ACPI; however, the reboot issue probably isn't.  Unless someone
can enlighten me?

On 9/16/05, Michal Jaegermann <michal@ellpspace.math.ualberta.ca> wrote:
> On Fri, Sep 16, 2005 at 11:57:16AM -0700, Mike Mohr wrote:
> > However, if I go into suspend to ram (which I
> > think is ACPI S3) where the display is turned off -or- I reboot
> > without shutting down first, the display is not re-initialized.
> 
> Did you try with 'acpi_sleep=s3_bios' kernel parameter as documentation
> suggests?  I have the same problem with video on Acer Travelmate and
> this helps.  Remember that with ACPI (or APM) you are to a great extent
> at a mercy of your BIOS supplier and that part is often seriously buggy.
> APM is simpler so it often used to be in a better shape.
> 
>    Michal
>
