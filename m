Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143676AbRAHPz4>; Mon, 8 Jan 2001 10:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143977AbRAHPzq>; Mon, 8 Jan 2001 10:55:46 -0500
Received: from smtp4.libero.it ([193.70.192.54]:64142 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id <S143676AbRAHPze>;
	Mon, 8 Jan 2001 10:55:34 -0500
Date: Mon, 8 Jan 2001 18:54:47 +0100
From: antirez <antirez@invece.org>
To: Heitzso <xxh1@cdc.gov>
Cc: "'Greg KH'" <greg@wirex.com>, "'antirez@invece.org'" <antirez@invece.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: Re: USB broken in 2.4.0
Message-ID: <20010108185447.G7498@prosa.it>
Reply-To: antirez@invece.org
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7FA5@mcdc-atl-5.cdc.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7FA5@mcdc-atl-5.cdc.gov>; from xxh1@cdc.gov on Mon, Jan 08, 2001 at 10:38:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 10:38:31AM -0500, Heitzso wrote:
> so that's where the break occurred.

The problem was fixed (new interface don't allow
a bulk read to be more than PAGE_SIZE, often 4096 bytes)
Read the thread for more information.
You can download the fixed s10sh at
http://www.kyuzz.org/antirez/s10sh.html

antirez

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
