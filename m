Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBkC>; Fri, 5 Jan 2001 20:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRAFBjx>; Fri, 5 Jan 2001 20:39:53 -0500
Received: from smtp2.libero.it ([193.70.192.52]:37031 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S129324AbRAFBjo>;
	Fri, 5 Jan 2001 20:39:44 -0500
Date: Sat, 6 Jan 2001 04:40:47 +0100
From: antirez <antirez@invece.org>
To: antirez <antirez@invece.org>
Cc: Greg KH <greg@wirex.com>, Heitzso <xxh1@cdc.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: Re: USB broken in 2.4.0
Message-ID: <20010106044047.B1748@prosa.it>
Reply-To: antirez@invece.org
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F99@mcdc-atl-5.cdc.gov> <20010105100040.A25217@wirex.com> <20010106000429.K7784@prosa.it> <20010106033936.A1748@prosa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010106033936.A1748@prosa.it>; from antirez@invece.org on Sat, Jan 06, 2001 at 03:39:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 03:39:36AM +0100, antirez wrote:
> s10sh reads 0x1400 bytes at once downloading jpges from the
> digicam, but the ioctl() that performs the bulk read fails with 2.4
> using this size. If I resize it (for example to 0x300) it works without
> problems (with high performace penality, of course, 60% of slow-down).

I checked it better: the largest bulk read I can perform is of 4096 bytes
(up to 5120 bytes with old kernels).

antirez

(please CC me)

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
