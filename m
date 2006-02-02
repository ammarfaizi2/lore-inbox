Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWBBXM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWBBXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWBBXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:12:56 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:1774 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751185AbWBBXMz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:12:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kVcRKjZhwtCb01WRiIvQzOkQrv7zpbq9nOr/mv8tKD9TbJl/VqMbFDS4ciNYAd/gQShkOMc8Sgh4wjAlsoutqNg73DRmrfDSnkLrjMz7S/+d7hQeglMz6eljWBoAZjjZX9rj52JLydLYcfo5Y19fruShnADKKJwfKk9HvfNq3As=
Message-ID: <d120d5000602021512x42be2006h31e63cb6d78ac1b3@mail.gmail.com>
Date: Thu, 2 Feb 2006 18:12:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Shaun Jackman <sjackman@gmail.com>
Subject: Re: [PATCH] liyitec: Liyitec PS/2 touchscreen driver
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <7f45d9390602021502q325752d7oe635569cde7ce2c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390602021502q325752d7oe635569cde7ce2c7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Shaun Jackman <sjackman@gmail.com> wrote:
> [PATCH] liyitec: Liyitec PS/2 touchscreen driver
>
> Add an input driver for the Liyitec PS/2 touchscreen.
>

I don't see any suibstantial differences from the older patch. I think
it should be integrated into psmouse. Is there a way to query the
device? What kind of boxes use this touchscreen? Maybe using DMI is an
option, like lifebook does?

--
Dmitry
