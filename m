Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSJVBQa>; Mon, 21 Oct 2002 21:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJVBQa>; Mon, 21 Oct 2002 21:16:30 -0400
Received: from pc132.utati.net ([216.143.22.132]:36992 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261590AbSJVBQ3> convert rfc822-to-8bit; Mon, 21 Oct 2002 21:16:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: "Guillaume Boissiere" <boissiere@adiglobal.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [STATUS 2.5]  October 21, 2002
Date: Mon, 21 Oct 2002 15:22:35 -0500
User-Agent: KMail/1.4.3
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       davej@suse.de, davem@redhat.com,
       "Guillaume Boissiere" <boissiere@adiglobal.com>, mingo@redhat.com
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost>
In-Reply-To: <3DB3AB3E.23020.5FFF7144@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210211522.35843.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2002 06:22, Guillaume Boissiere wrote:
> Updated my list with changes pointed out by Rob and Rusty.

Cool. :)

> http://www.kernelnewbies.org/status/

But wait, there's more! :)  Specfically, four or five new items at the end of 
the list, a bit more research on the unresolved stuff, and one dropped item 
(zoom support) which Alan said was just a driver forward-port from 2.4 rather 
than a significant new feature.

I'll post the updated one in a minute or two...

> I am not too clear what exactly is expected to be merged for
> IPv6 (everything from USAGI?) so I removed it and replaced
> by IPsec and CryptoAPI.

I'm waiting to hear about that myself...

> Also, are initramfs, ext2/3 resize for 2.7/3.1?

Initramfs somebody has to ask Al Viro about, but at this point, the user space 
stuff (including H. Peter Anvin's klib) to make initramfs useful isn't ready 
enough for it to be useful, so I'm guessing it's next unstable series.

The main benefit from initramfs is the ability to rip stuff out of the kernel 
and put it in userspace early.  There's not likely to be much ripping out 
done after the feature freeze, so even if the infrastructure went in at this 
point...

Rob
