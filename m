Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290201AbSALBMd>; Fri, 11 Jan 2002 20:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290204AbSALBMO>; Fri, 11 Jan 2002 20:12:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63750 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290202AbSALBMI>;
	Fri, 11 Jan 2002 20:12:08 -0500
Date: Sat, 12 Jan 2002 01:12:07 +0000
From: Chris Dukes <pakrat@www.uk.linux.org>
To: fabrizio.gennari@philips.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: PPP over socket?
Message-ID: <20020112011207.F7199@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <OF89E28C88.FEBD33E7-ONC1256B3E.002E62B6@diamond.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF89E28C88.FEBD33E7-ONC1256B3E.002E62B6@diamond.philips.com>; from fabrizio.gennari@philips.com on Fri, Jan 11, 2002 at 10:13:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 10:13:57AM +0100, fabrizio.gennari@philips.com wrote:
> I was wondering whether the socket architecture could be modified in order 
> to support PPP connections over a generic socket (of type SOCK_DGRAM or 
> SOCK_SEQPACKET), by mapping each PPP packet to a socket packet. This idea 
> is not completely new: somebody raised is in the past, see for example 
> http://oss.sgi.com/projects/netdev/mail/netdev/msg00180.html or 
> http://oss.sgi.com/projects/netdev/mail/netdev/msg01127.html .

vtun already provides this capability in user space.
(See http://vtun.sourceforge.net/)
ppp(8) on *BSD also provides this capability in user space as well.

As memory serves PPPoE on Linux is partially implemented in userspace
as is, so a partial user space solution for PPPoUDP shouldn't be that
wretched.
-- 
Chris Dukes
"Bert is apparently EEEEVIL, whereas Oscar is just a sysadmin^Wgrouch."
-- gorski
