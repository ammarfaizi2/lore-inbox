Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWFAW2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWFAW2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWFAW2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:28:43 -0400
Received: from xenotime.net ([66.160.160.81]:65421 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750804AbWFAW2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:28:42 -0400
Date: Thu, 1 Jun 2006 15:31:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: input: fix comments and blank lines in new ff code
Message-Id: <20060601153125.b8f7672a.rdunlap@xenotime.net>
In-Reply-To: <447F6725.9010806@gmail.com>
References: <20060530105705.157014000@gmail.com>
	<20060530110131.136225000@gmail.com>
	<20060530222122.069da389.rdunlap@xenotime.net>
	<447F3AE4.6010206@gmail.com>
	<20060601125256.de2897f4.rdunlap@xenotime.net>
	<447F47FD.2050705@gmail.com>
	<20060601130923.38f83fb6.rdunlap@xenotime.net>
	<20060601204716.GA6847@delta.onse.fi>
	<20060601143356.f5b8d4f5.rdunlap@xenotime.net>
	<447F6725.9010806@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 01:16:05 +0300 Anssi Hannula wrote:

> 
> I've no problem with Thunderbird anymore as I configured it to use
> gmail.com TLS SMTP server instead for emails where From is my gmail.com
> address. However I can't send inline patches using Thunderbird, only
> MIME attachments (they are in cleartext and have "Content-Disposition:
> inline", however).

check out http://mbligh.org/linuxdocs/Email/Clients/Thunderbird

I have also written a few emails about how to use thunderbird
successfully, but I don't have links to them... :(


> The patch was sent with another client to avoid using a MIME attachment,
> but that client was configured for my ISP's SMTP server.
> 
> I don't really know if a MIME attachment or "wrong" From email address
> is a bigger nuisance.

For me, it's attachments.  Especially if you make the first line
of your patch be the correct:
From: your name <name@example.com>


> > And I noticed one function name _input_ff_erase().
> > That might be a namespace violation... anyone know the namespace
> > rules?
> 
> Namespace violation? Never heard of that one.

Kernel (usually?) uses names of the form xyz_abc or __xyz_abc,
not (one underscore) _xyz_abc.  Has something to do with POSIX
namespace, but I don't know more about it.

---
~Randy
