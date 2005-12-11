Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbVLKFsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbVLKFsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbVLKFsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:48:22 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:31696 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161102AbVLKFsV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:48:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jyJUL/Jk9ycv8JcTyHLGBRHNgsHIWWDkRKaoJm0eN86uqdyK/JBQeURH5OQHAeqFKoETfV6uCdphV3jedAXjkjrwCtCHbrWsj50L9lpic7X9vQWsd/yINAZcPcqgx76jLdYnCUgblEC9xM5S2fuG2xH9VN+wYXhcPKN9QR8vDvE=
Message-ID: <81083a450512102148u2db386aat7ad51056bcc02f82@mail.gmail.com>
Date: Sun, 11 Dec 2005 11:18:20 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Miloslav Trmac <mitr@volny.cz>
Subject: Re: [PATCH] drivers/input/misc: Added Acer TravelMate 240 support to the wistron button interface
Cc: bero@arklinux.org, dtor@mail.ru, akpm@osdl.org, vojtech@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org
In-Reply-To: <439BB8CC.4000301@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512102116o50d71fa0gbb53557f0e3d8748@mail.gmail.com>
	 <439BB8CC.4000301@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Miloslav Trmac <mitr@volny.cz> wrote:

> > This patch adds Acer TravelMate 240 support to the wistron button
> > interface. This means that the buttons on top of the
> > keyboard(including ones for Wifi and Bluetooth),  which hitherto did
> > not work, work now. I have tested it on my laptop and it seems to work
> > great.
> Please check that the ACPI "button.ko" driver can't provide the
> functionality; newer laptops apparently work better with that driver
> (http://lkml.org/lkml/2005/12/2/61).

The Acer TravelMate 240 laptop supports ACPI, but the ACPI does not
support hotkeys. Hence hotkeys just would not work without this
module.

Regards
Ashutosh
