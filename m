Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRANSIs>; Sun, 14 Jan 2001 13:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132777AbRANSIi>; Sun, 14 Jan 2001 13:08:38 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:3076 "HELO kamov.deltanet.ro")
	by vger.kernel.org with SMTP id <S132413AbRANSI0>;
	Sun, 14 Jan 2001 13:08:26 -0500
Date: Sun, 14 Jan 2001 20:08:09 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
Message-ID: <20010114200809.P1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net> <14945.32886.671619.99921@pizda.ninka.net> <20010114124549.D1394@ppetru.net> <14945.34414.185794.396720@pizda.ninka.net> <20010114132845.F1394@ppetru.net> <14945.36440.59585.376942@pizda.ninka.net> <20010114141003.G1394@ppetru.net> <20010114151257.J1394@ppetru.net> <14945.42973.905573.579075@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <14945.42973.905573.579075@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 05:21:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 05:21:33AM -0800, David S. Miller wrote:
> Petru Paler writes:
>  > Got more "udp v4 hw csum failure" messages but still no "UDP packet
>  > with bad csum was fragmented".
> 
> OK, last experiment :-)  Add this patch, and watch to see if
> the UDP "InErrors" field in /proc/net/snmp has a non-zero value after
> letting it run for a while.  Thanks.

Ok, will do.

In the mean time, the box locked up hard. The last message in syslog
was:

Jan 14 10:14:45 grey kernel: Undo loss 194.67.160.18/3103 c2 l0 ss2/65535 p0              

I'm not sure when it died, and I also could not check the console (the
server is on the other side of the planet for me :).

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
