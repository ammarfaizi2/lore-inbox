Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281775AbRKUNNB>; Wed, 21 Nov 2001 08:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281889AbRKUNNA>; Wed, 21 Nov 2001 08:13:00 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:7856 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S281775AbRKUNM1>; Wed, 21 Nov 2001 08:12:27 -0500
Date: Wed, 21 Nov 2001 14:12:25 +0100
From: bert hubert <ahu@ds9a.nl>
To: Anton Blanchard <anton@samba.org>
Cc: Lee Chin <leechinus@yahoo.com>,
        "linux, kernel" <linux-kernel@vger.kernel.org>,
        Linux Net <linux-net@vger.kernel.org>
Subject: Re: sendfile from sockets
Message-ID: <20011121141225.A10302@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Anton Blanchard <anton@samba.org>, Lee Chin <leechinus@yahoo.com>,
	"linux, kernel" <linux-kernel@vger.kernel.org>,
	Linux Net <linux-net@vger.kernel.org>
In-Reply-To: <20011119060850.53289.qmail@web14311.mail.yahoo.com> <20011119171653.E6367@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119171653.E6367@krispykreme>; from anton@samba.org on Mon, Nov 19, 2001 at 05:16:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 05:16:53PM +1100, Anton Blanchard wrote:
> > Is this a kernel limitation?
> 
> Yes, the manpage needs updating, you can only sendfile() from
> something that exists in the pagecache (ie not a socket).

The most recent manpages show this correctly. 

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
