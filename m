Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSBVOMo>; Fri, 22 Feb 2002 09:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292869AbSBVOMe>; Fri, 22 Feb 2002 09:12:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39684 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292867AbSBVOM1>;
	Fri, 22 Feb 2002 09:12:27 -0500
Message-ID: <3C7651C7.59198769@mandrakesoft.com>
Date: Fri, 22 Feb 2002 09:12:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Feb 22, 2002 at 02:45:32PM +0100, Martin Dalecki wrote:
> > The chipset drivers will register lists of PCI-id's they can handle
> > instead of the single only global list found in ide-pci.c.
> 
> I think it'd be even better if the chipset drivers did the probing
> themselves, and once they find the IDE device, they can register it with
> the IDE core. Same as all the other subsystem do this.

Yes.  I've mentioned before converting the IDE driver into a sort of
structure, but it always boiled down to "that requires a complete
rewrite" reply to me...  If someone accomplishes such, I would be happy.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
