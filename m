Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278676AbRJXRM7>; Wed, 24 Oct 2001 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278675AbRJXRMt>; Wed, 24 Oct 2001 13:12:49 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:24537 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S278672AbRJXRMj>; Wed, 24 Oct 2001 13:12:39 -0400
Message-ID: <3BD6F701.32E34BA5@nortelnetworks.com>
Date: Wed, 24 Oct 2001 13:14:41 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
Cc: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
        David Ford <david@blue-labs.org>, Julian Anastasov <ja@ssi.bg>,
        Tim Hockin <thockin@sun.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <200110241534.f9OFYnL14565@www.hockin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> > > Switch to 'ip' instead of 'ifconfig', several large distros now include
> > > it.  Addresses can be added and removed completely indiscriminately on
> > > interfaces.
> > >
> > > The "ethN:X" is a legacy design that is now deprecated.
> >
> > Minor issue...if I create (using 'ip') two addresses on the same subnet on the
> > same device, one of them is primary and the other is secondary.  If I then
> > delete the primary address, the second one goes with it.
> >
> > I submit that this is bad behaviour.
> 
> This is the same behavior for which I am proposing fixing.  The origin of
> the thread, if you will.

Yes, precisely.  I was rebutting David Ford's statement above about addresses
being added and removed indiscriminately using 'ip' but not using aliases.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
