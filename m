Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752376AbWKBMN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbWKBMN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbWKBMN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:13:58 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:10002 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752376AbWKBMN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:13:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pGgLguiLldMT54EiW2RGfCkUG+l8wdL0xLggEEIohhaJyYd0/gj3MgBhsgLyvaAZpVKHgJaAo7lJQYEerJ2snFXAl+wHLDxfTeW6c5OnvX3r4weF2REhCGB8gM/O+WhdFynui9qH8MYVZcKxgjQIDeY4QLDVhytcFogaMoR8ydA=
Message-ID: <3ae72650611020413q797cf62co66f76b058a57104b@mail.gmail.com>
Date: Thu, 2 Nov 2006 13:13:56 +0100
From: "Kay Sievers" <kay.sievers@vrfy.org>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md array starts/stops.
Cc: NeilBrown <neilb@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061031211615.GC21597@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061031164814.4884.patches@notabene> <1061031060046.5034@suse.de>
	 <20061031211615.GC21597@suse.de>
X-Google-Sender-Auth: a4790aa97c9c84b2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Greg KH <gregkh@suse.de> wrote:
> On Tue, Oct 31, 2006 at 05:00:46PM +1100, NeilBrown wrote:
> >
> > This allows udev to do something intelligent when an
> > array becomes available.
> >
> > cc: gregkh@suse.de
> > Signed-off-by: Neil Brown <neilb@suse.de>
>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

I don't agree with this, and asked several times to change this to
"change" events, like device-mapper is doing it to address the same
problem. Online/offline is not supported by udev/HAL and will not work
as expected. Please fix this.

Thanks,
Kay
