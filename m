Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281050AbRKOUti>; Thu, 15 Nov 2001 15:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKOUt2>; Thu, 15 Nov 2001 15:49:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:24837 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281050AbRKOUtL>;
	Thu, 15 Nov 2001 15:49:11 -0500
Subject: Re: AMD 761 support in Linux
From: Robert Love <rml@tech9.net>
To: Jeff Weeks <jweeks@MailAndNews.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF4EEE3@MailAndNews.com>
In-Reply-To: <3BF4EEE3@MailAndNews.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 15 Nov 2001 15:49:28 -0500
Message-Id: <1005857369.11992.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-15 at 15:41, Jeff Weeks wrote:
> Sorry to bother you, but I noticed a message of yours on the internet which 
> said, to enable AMD 761 support in Linux you should set 
> "agp_try_unsupported=3D1" option... but where?
>  
> There's no option for that in the kernel config, so I'm assuming it's in a 
> header file somewhere, or something.  I've got AGP support compiled directly 
> in the kernel, so I can't specify it as a module parameter... and I'd like to 
> keep it right in the kernel if possible.

Upgraded to at least 2.4.11 (2.4.14 is newest) and make sure AMD AGPGART
is enabled -- I added AMD 761 support.

You can also try this patch
	http://tech9.net/rml/linux/patch-rml-2.4.10-pre9-AMD_761-AGP-2
but I would recommend going with kernel 2.4.14.

P.S. This is a mailing list

	Robert Love

