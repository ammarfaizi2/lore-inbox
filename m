Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWCHUrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWCHUrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWCHUrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:47:16 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:17000 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932457AbWCHUrQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:47:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qwsDRKPIE5SwIrhyt7a7Eg04oHemxYEdlBpN3red6CVFbU8JwuxHC9yEgJjykqAyMunkrAWdgn29DJJf3F/8uzZmjHF4PeakoaG3hGmOltzy3JBkRTFB7VAgDNVxVkKAwUZeDDZqBeJ2UKXasxGLywoVQrCDFI6/M8t2bCSTvaU=
Message-ID: <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com>
Date: Wed, 8 Mar 2006 15:47:15 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: usbkbd not reporting unknown keys
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
	 <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> Just discovered it needs usb debugging to be set. But isnt
> inconsistent the fact that the atkbd driver does this differently from
> the usbkbd driver? If its a good idea to print those messages by
> default or one, why its not for the other?

usbkbd will only report standard keys and is supposed in limited
circumstances so it complaining about unknown keys is not very useful.
Why do you need it? Doesn't hid driver work for you?

--
Dmitry
