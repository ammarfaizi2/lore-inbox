Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279823AbRKAWgV>; Thu, 1 Nov 2001 17:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279822AbRKAWgL>; Thu, 1 Nov 2001 17:36:11 -0500
Received: from toad.com ([140.174.2.1]:62726 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S279818AbRKAWgE>;
	Thu, 1 Nov 2001 17:36:04 -0500
Message-ID: <3BE1CE30.D48D30E7@mandrakesoft.com>
Date: Thu, 01 Nov 2001 17:35:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Vier <tmv5@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: alpha tru64 mmap broken in linus kernels
In-Reply-To: <20011101172412.A578@zero>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:
> alan's 2.4.13-ac* kernels work fine, but using 2.4.13, mmap fails for tru64
> binaries. i tried applying an old fix for it (similar to the one that's in
> alan's tree now), but it still fails. does anyone have a patch to fix
> mm/mmap.c in linus's kernels? 2.4.14-pre6 is still broken.

I think Linus is concentrating mainly on the VM right now.  One of
myself, Alan, or rth will resend the alpha fixes to Linus once he opens
up the patch floodgates again :)

If you need the patch to fix alpha, simply take alan's patch and cut
away the non-alpha parts.  I think the only thing that doesn't need to
get merged over to the Linus tree is the init_mmap stuff.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
