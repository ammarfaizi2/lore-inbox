Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSALBpR>; Fri, 11 Jan 2002 20:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbSALBpI>; Fri, 11 Jan 2002 20:45:08 -0500
Received: from freeside.toyota.com ([63.87.74.7]:63499 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S274862AbSALBpD>; Fri, 11 Jan 2002 20:45:03 -0500
Message-ID: <3C3F950F.8010700@lexus.com>
Date: Fri, 11 Jan 2002 17:44:47 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Dukes <pakrat@www.uk.linux.org>
CC: fabrizio.gennari@philips.com, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: PPP over socket?
In-Reply-To: <OF89E28C88.FEBD33E7-ONC1256B3E.002E62B6@diamond.philips.com> <20020112011207.F7199@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just my $.02 -

vtund rocks, I learned about it when
I took on a side job doing linux/vpn
admin for a medium size company.

vtund connects their branch offices
to their main office - it encrypts and
compresses traffic between the vpn
boxes at each end, which in our case
are iptables firewall boxes.

I am impressed with it  - as mentioned
it's user space and works with linux,
bsd or solaris....

cu

jjs

Chris Dukes wrote:

>On Fri, Jan 11, 2002 at 10:13:57AM +0100, fabrizio.gennari@philips.com wrote:
>
>>I was wondering whether the socket architecture could be modified in order 
>>to support PPP connections over a generic socket (of type SOCK_DGRAM or 
>>SOCK_SEQPACKET), by mapping each PPP packet to a socket packet. This idea 
>>is not completely new: somebody raised is in the past, see for example 
>>http://oss.sgi.com/projects/netdev/mail/netdev/msg00180.html or 
>>http://oss.sgi.com/projects/netdev/mail/netdev/msg01127.html .
>>
>
>vtun already provides this capability in user space.
>(See http://vtun.sourceforge.net/)
>ppp(8) on *BSD also provides this capability in user space as well.
>
>As memory serves PPPoE on Linux is partially implemented in userspace
>as is, so a partial user space solution for PPPoUDP shouldn't be that
>wretched.
>


