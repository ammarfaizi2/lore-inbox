Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279838AbRKRPSq>; Sun, 18 Nov 2001 10:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279839AbRKRPSg>; Sun, 18 Nov 2001 10:18:36 -0500
Received: from t2.redhat.com ([199.183.24.243]:36080 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S279838AbRKRPSb>; Sun, 18 Nov 2001 10:18:31 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E165TiE-0003Vv-00@the-village.bc.nu> 
In-Reply-To: <E165TiE-0003Vv-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Symbols missing help 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Nov 2001 15:18:20 +0000
Message-ID: <27833.1006096700@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Umm.. the policy has been rude words in source code = ok, rude word
> in errors that might one day appear to a user = not ok

That message should _never_ appear to a user. Anyone who wants to
gratuitously change that can write a suitable help text.

Actually I'm hoping that CML2, if adopted, will allow us to get rid of the 
CONFIG_MEMORY_SET cruft in arch/sh/config.in altogether. 

But not, of course, until after the initial adoption of the CML2 codebase -
actual changes to the behaviour of the config options _must_ be done 
separately to the change in mechanism.

--
dwmw2


