Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276839AbRJHKO3>; Mon, 8 Oct 2001 06:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276841AbRJHKOU>; Mon, 8 Oct 2001 06:14:20 -0400
Received: from elin.scali.no ([62.70.89.10]:4 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S276839AbRJHKOF>;
	Mon, 8 Oct 2001 06:14:05 -0400
Message-ID: <3BC17B6D.A656DAAB@scali.no>
Date: Mon, 08 Oct 2001 12:09:49 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy-Magne Mo <rmo@sunnmore.net>
CC: Willem Riede <wriede@home.com>, Steven Walter <srwalter@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Tyan Tiger MP AMD760 chipset support
In-Reply-To: <20011007132349.A1424@linnie.riede.org> <20011007141205.B4000@hapablap.dyn.dhs.org> <20011007153942.C1424@linnie.riede.org> <20011007223400.C8033@akkar.interpost.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy-Magne Mo wrote:
> 
> On Sun, Oct 07, 2001 at 03:39:42PM -0400, Willem Riede wrote:
> > That's not the issue, I'm not that ignorant. sensors-detect
> > just doesn't find anything!
> 
> Upgrade to the cvs version of lm_sensors and the i2c drivers.
> 
> I can with these modules detect the eeprom, the AMD756 and the
> winbond W83782D.
> 
> But, however, inserting the winbond driver locks the computer hard.
> 
I've had the same problem with two Tyan Thunder K7 motherboards, inserting the
winbond driver locks the computer hard. However booting with the "noapic" option
solves this. Ideas anyone ? Are the AMD erratas publicly available ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
