Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291340AbSBSMLj>; Tue, 19 Feb 2002 07:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291343AbSBSML3>; Tue, 19 Feb 2002 07:11:29 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:22205 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S291340AbSBSMLW>; Tue, 19 Feb 2002 07:11:22 -0500
Date: Tue, 19 Feb 2002 13:11:21 +0100
From: bert hubert <ahu@ds9a.nl>
To: Jim Roland <jroland@roland.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel ethernet alias limit
Message-ID: <20020219131121.A6383@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jim Roland <jroland@roland.net>, linux-kernel@vger.kernel.org
In-Reply-To: <000701c1b929$33a47c60$ab9eef0c@jimws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c1b929$33a47c60$ab9eef0c@jimws>; from jroland@roland.net on Tue, Feb 19, 2002 at 09:39:30AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 09:39:30AM +0000, Jim Roland wrote:
> I seem to remember back in either Kernel 2.0 or 2.2 there was a limit of 256
> aliases within the ethX aliasing (eg, eth0, then eth0:0 thru eth0:255).
> 
> Has the limit on this been expanded with Kernel 2.4, is it stable and/or
> advised?  I have a need to bind more than 256 addresses to a single
> interface.  Without installing additional network cards.

Use a loopback interface - you can easily bind to a /8 if you want this way.

I think this is documented in the 'ip' documentation in 'iproute2' from
Alexey. It has also been explained on list here.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
