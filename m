Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289103AbSANWZo>; Mon, 14 Jan 2002 17:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289110AbSANWZh>; Mon, 14 Jan 2002 17:25:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27409 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289107AbSANWYt>;
	Mon, 14 Jan 2002 17:24:49 -0500
Message-ID: <3C435AAE.F3AEB93@mandrakesoft.com>
Date: Mon, 14 Jan 2002 17:24:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
In-Reply-To: <20020114165909.A20808@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> Penelope needs to build a kernel to support her exotic driver, but she
> hasn't got more than the vaguest idea how to go about it.  The
> instructions with the driver source patch tell her to apply it at the
> top level of a current Linux source tree and then just say "build the
> kernel" before getting off into technicalia about the user-space
> tools.

Very few hardware vendors give out kernel patches... if any.  The end
user method of choice I've seen is a tarball with files to build, or a
single .c file to build.  Kernel autoconfiguration for vendor drivers
rarely comes into play, because the driver is built against the "current
kernel" headers, but not with the standard kernel build system and
tools.

Oh, and is Penelope single?

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
