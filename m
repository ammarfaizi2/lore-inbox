Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132050AbRANKqX>; Sun, 14 Jan 2001 05:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRANKqN>; Sun, 14 Jan 2001 05:46:13 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:6418 "HELO kamov.deltanet.ro")
	by vger.kernel.org with SMTP id <S132050AbRANKqE>;
	Sun, 14 Jan 2001 05:46:04 -0500
Date: Sun, 14 Jan 2001 12:45:49 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
Message-ID: <20010114124549.D1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net> <14945.32886.671619.99921@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <14945.32886.671619.99921@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 02:33:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 02:33:26AM -0800, David S. Miller wrote:
> Petru Paler writes:
>  > I get messages in syslog looking like:
>  > 
>  > Undo loss 192.147.174.183/59953 c2 l0 ss2/65535 p0
>  > Undo loss 63.148.232.53/4423 c2 l0 ss2/2 p0
>  > Undo loss 204.253.105.63/25 c2 l0 ss2/2 p0
> 
> These are normal, if they annoy you please change FASTRETRANS_DEBUG
> back to "1" in include/net/tcp.h
> 
> This is just an increased debugging setting compared to Linus's
> tree, the message you see is harmless.

Ok. Should I keep reporting new syslog messages as they appear ? This
machine has lots of traffic, both TCP (SMTP) and UDP (DNS). Since the
last email I also got (minus the "Undo loss" ones, and I only included one
of each message types, as they repeat):

Undo partial loss 193.230.129.57/33659 c1 l5 ss2/3 p5

udp v4 hw csum failure.                                                                   

Disorder0 3 5 f0 s1 rr1                                                                   

Undo Hoe 203.162.5.28/25 c8 l1 ss5/65535 p8                                               

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
