Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272788AbRIGRYX>; Fri, 7 Sep 2001 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272785AbRIGRYF>; Fri, 7 Sep 2001 13:24:05 -0400
Received: from math.uci.edu ([128.200.174.70]:21662 "EHLO math.uci.edu")
	by vger.kernel.org with ESMTP id <S272784AbRIGRYB>;
	Fri, 7 Sep 2001 13:24:01 -0400
From: Eric Olson <ejolson@math.uci.edu>
Message-Id: <200109071723.KAA03673@math.uci.edu>
Subject: Some experiences with the Athlon optimisation problem
To: heinz@auto.tuwien.ac.at
Date: Fri, 7 Sep 2001 10:23:59 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
Reply-To: ejolson@math.uci.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, it should be "Core" Temperature not "Case" Temperature below.
The AMD Athlon Processor Model 4 Data Sheet summary on page 71 also
made this typo and I blindly copied it.  --Eric

>Dear Heinz Deinhart,
>
>>The old Athlon reads: 
>>        A1133AMS3C 
>>        AVIA 0115TPAW 
>>        95262550081 
>>
>>The new (non working) one: 
>>        A1200AMS3C 
>>        AXIA 0121RPDW 
>>        95987660990 
>
>The first line can be decoded using AMDs documentation at
>
>    http://www.amd.com/products/cpg/athlon/techdocs/index.html
>
>In particular
>
>       A 1133 A M S 3 C
>       |   |  | | | | |
>       |   |  | | | |  \___ FSB (B=200, C=266)
>       |   |  | | |  \_____ Size of L2 Cache (3=256K)
>       |   |  | |  \_______ Case Temperature (S=95C, T=90C)
>       |   |  |  \_________ Operating Voltage (M=1.75V, P=1.7V)
>       |   |   \___________ Package Type (A=PGA)
>       |    \______________ Speed in MHz
>        \__________________ A for Athlon
>
>Anyone know what the second line means?  It is quite mysterious 
>that the word VIA appears on the chip that works with VIA KT133A 
>and not on the other :-)
>
>Have you tried Robert Redelmeier's new program burnMMX2 which has 
>the 3DNow streaming cache bypass load/store instructions that seem 
>to be causing all the trouble?
>
>Does it run indefinitely or terminate with the 1133MHz processor 
>configuration?  What about for the 1200MHz processor with kernel 
>optimization turned off?
>
>--Eric
>

