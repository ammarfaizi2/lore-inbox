Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131947AbRANL3N>; Sun, 14 Jan 2001 06:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132302AbRANL3E>; Sun, 14 Jan 2001 06:29:04 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:13330 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S131947AbRANL2v>;
	Sun, 14 Jan 2001 06:28:51 -0500
Date: Sun, 14 Jan 2001 13:28:45 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
Message-ID: <20010114132845.F1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net> <14945.32886.671619.99921@pizda.ninka.net> <20010114124549.D1394@ppetru.net> <14945.34414.185794.396720@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <14945.34414.185794.396720@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 02:58:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 02:58:54AM -0800, David S. Miller wrote:
> Petru Paler writes:
>  > Ok. Should I keep reporting new syslog messages as they appear ?
> 
> Not the "Undo ***" and "Disorder ***" ones".

Ok.

> But this one is curious:
> 
>  > udp v4 hw csum failure.                                                                   
> Oh, I think I know why this happens.  Can you add this patch, and next
> time the UDP bad csum message appears, tell me if it says "UDP packet
> with bad csum was fragmented." in the next line of your syslog
> messages?  Thanks.

Sure, but I also need the actual patch :)

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
