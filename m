Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129964AbRBEIlt>; Mon, 5 Feb 2001 03:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131576AbRBEIlj>; Mon, 5 Feb 2001 03:41:39 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:25790 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129964AbRBEIlX>;
	Mon, 5 Feb 2001 03:41:23 -0500
Date: Mon, 5 Feb 2001 09:41:19 +0100
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Robert Siemer <Robert.Siemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix dependencies for radio-miropcm20
Message-ID: <20010205094119.A28654@fenrus.demon.nl>
In-Reply-To: <3A7C6949.3070705@netgem.com> <20010204033125C.siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010204033125C.siemer@panorama.hadiko.de>; from Robert.Siemer@gmx.de on Sun, Feb 04, 2001 at 03:31:25AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2001 at 03:31:25AM +0100, Robert Siemer wrote:
> This was already discussed some days ago. Arjan said, that the
> miropcm20 question comes before the aci question, so this is
> useless. - Arjan, this is not true for 'make menuconfig' and 'make
> xconfig', isn't it?

make [x,menu]config are a bit smarter, but at least make menuconfig has the
annoying behavior of hiding the question for the Miro card until you
magically turn on the ACI mixer in the sound section. This confuses the hell
out of peope when they go through make menuconfig "top bottom".

Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
