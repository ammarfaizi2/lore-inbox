Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278788AbRKAMCW>; Thu, 1 Nov 2001 07:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278792AbRKAMCM>; Thu, 1 Nov 2001 07:02:12 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:43531 "HELO due.stud.ntnu.no")
	by vger.kernel.org with SMTP id <S278788AbRKAMCA>;
	Thu, 1 Nov 2001 07:02:00 -0500
Date: Thu, 1 Nov 2001 13:00:44 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Juergen Hasch <Hasch@t-online.de>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011101130044.D3409@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <15yzpC-26N6dEC@fwd04.sul.t-online.com> <20011101141111.A27180@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011101141111.A27180@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Thu, Nov 01, 2001 at 02:11:11PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> It should be Rx_TCO_Packets, not Tx.
> The problem described in Intel's advisory is related to incorrect processing
> of receiving packets.

But if it's this bug that's triggered with NFS-traffic, then the counter
should be increasing with every timeout, right? Not just one time. I get a
lot of timeout and the counter is still just 1.

I'm going out to buy me another NIC and try tests a bit systematically, and
report back with the results afterwards.

-- 
Thomas
