Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWCGQJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWCGQJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCGQJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:09:31 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:21341 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751236AbWCGQJb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:09:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yd5SaZiLEGcKx4Ka2fH0MjRMeGbnO76aTq8lgvkwcOxYud+0RZ9f10euQA5MWjmZP//DMoP6CBh8u/IzIOT1jwvLkLe4WcZmH2U5XRENl7wbXIuVjnVU7OdP3HYv6hfSGGrFB3XonRif0lGd7eI1S+AFN0L0g7xJY7o3pBMLbUg=
Message-ID: <756b48450603070809i65a08b3aga99c72509f736c3f@mail.gmail.com>
Date: Tue, 7 Mar 2006 11:09:28 -0500
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B22A242@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ACA40606221794F80A5670F0AF15F840B22A242@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Yu, Luming <luming.yu@intel.com> wrote:
> >I've added it as an attachment here. Please let me know if you get it.
> >
> I just found this:
>             Device (SVG)
>                 Device (LCD)
> It looks too simple to fit video.c.

I'm sorry but I'm confused. Do you mean that I shouldn't try to
support the brightness using the default video driver (ie: leave it as
a board specific driver because the board's ACPI implementation for
video support is insufficient) or did you mean that it will be easy
and simple to fit in video.c?

> But it is quite easy to implement in hotkey.c.
> Because it has dedicated device with HID and ,
> well-known method name.
>

I'm confused by hotkey here. I'm not sure how hotkey is involved here.
The Atlas board has no  keys physically. It has buttons which are
hooked up using the ASIM HID and that is what I am trying to support
since those physically exist on the board. Can you help me understand
how hotkey is involved in this?

Thanks,
jayakumar
