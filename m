Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSKMAAG>; Tue, 12 Nov 2002 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSKMAAG>; Tue, 12 Nov 2002 19:00:06 -0500
Received: from polomer.sinet.sk ([62.169.169.8]:38660 "EHLO polomer.sinet.sk")
	by vger.kernel.org with ESMTP id <S267034AbSKMAAF>;
	Tue, 12 Nov 2002 19:00:05 -0500
From: Peter Kundrat <kundrat@kundrat.sk>
Date: Wed, 13 Nov 2002 01:04:50 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio
Message-ID: <20021113000449.GB7015@napri.sk>
Mail-Followup-To: kundrat,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net> <1037144284.10029.0.camel@irongate.swansea.linux.org.uk> <20021112184349.A11757@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112184349.A11757@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 06:43:49PM -0500, Doug Ledford wrote:
> And in some implementations the codec control labelled PCM2 is actually 
> main volume, and I've seen one where a headphone was the actual main 
> volume.  So, the answer is tinker with all the available volume sliders to 
> see if you can find one that actually changes the volume of everything at 
> once, and if you do find it, use it.

Isnt there a way for userspace to somehow find this? It is a bit
annoying that main volume control in kmix doesnt work (and thus the one
in panel; also there is no headphone control there).
The other option would be to configure userspace which control is the
main one (but windows doesnt need that, so this solution would be
inferior). Eventually i will take a look what does the win driver (maybe
it sets main and headphone control always together). Until then i'd like
to hear what are our options .. since the current situation is not
really desirable.

Thanks for any ideas,

pkx
-- 
Peter Kundrat
peter@kundrat.sk
