Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282249AbRKWVid>; Fri, 23 Nov 2001 16:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282251AbRKWViO>; Fri, 23 Nov 2001 16:38:14 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:22207 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S282249AbRKWViI>; Fri, 23 Nov 2001 16:38:08 -0500
Date: Fri, 23 Nov 2001 22:38:07 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Etiquette of getting a driver into the kernel
Message-ID: <20011123223807.A15716@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20011123102828.D27980@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123102828.D27980@antefacto.com>; from john@antefacto.com on Fri, Nov 23, 2001 at 10:28:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 10:28:28AM +0000, John P. Looney wrote:

>  Basically, I've a patch for it against 2.4.15, and I'm wondering how I
> should go about getting it into the kernel, so others can debug it for me :)

It is both a social and a technical ritual, like a raindance. First you
start by removing the obviously ugly parts of your patch, and then continue
to polish it 'till it shines. Then you send a loving message to the relevant
subsystem maintainer, asking for his/her advice.

'How would you like to see this driver' is the question to ask. Mostly you
will then hear that you did everything wrong, that your tabstyle sucks, that
this would not survive 10 seconds on my 64G quad xeon and that it would be
far easier to modify driver x-y-z to support your hardware too, where x-y-z
is not in the least related to your problem.

This is the time to persist. What you are seeing is part of a necessary
ritual. Challenge the subsystem maintainer and show your respect by
following the saner parts of his message. Clean up your coding style, use
kernel infrastructure as suggested, heed arcane hints about locks that need
or to need to be held.

Resubmit and argue. Lobby. Document. Resubmit and argue. Keep sending patches. 

And in due time if everything is right, the subsystem maintainer will accept
your patch and feed it to Marcelo or Linus.

Some maintainers are more stubborn then others, by the way. But always keep
in mind that code is king and that it may take a while to bang it into
shape.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
