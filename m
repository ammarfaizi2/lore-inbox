Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271993AbRH2PTq>; Wed, 29 Aug 2001 11:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271994AbRH2PTg>; Wed, 29 Aug 2001 11:19:36 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:17651 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271993AbRH2PTV> convert rfc822-to-8bit; Wed, 29 Aug 2001 11:19:21 -0400
Importance: Normal
Subject: Re: VM: Bad swap entry 0044cb00
To: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Cc: "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF50C3DE71.2836FB36-ONC1256AB7.0052FBEB@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Wed, 29 Aug 2001 17:20:13 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 29/08/2001 17:19:27
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> But keep yesterday's testing patch in too, in case you find
> problems still (as Adrian Bunk reported on 2.4.9-ac2).

Hi Hugh,

as we still have to stuck with 2.4.7 I applied your patch, but the problem
isn´t fully solved. The error message still appears.
In some minutes I am going to vacation so for further questions, write to
Martin Schwidefsky. (schwidefsky@de.ibm.com) and cc Ulrich Weigand
(Ulrich.Weigand@de.ibm.com).

Sorry.

Bytheway now the messages were:

Out of Memory: Killed process 7090 (_18411Y45_s).
swap_free from 80030d04: Bad swap entry 0a9ca600
Out of Memory: Killed process 7841 (_18411Y46_s).
Out of Memory: Killed process 7861 (_18411Y47_s).
Out of Memory: Killed process 7993 (_18411Y48_s).
Out of Memory: Killed process 8020 (_18411Y47_s).
Out of Memory: Killed process 8153 (_18411Y48_s).
Out of Memory: Killed process 8260 (_18411Y85_s).
Out of Memory: Killed process 8345 (_18411Y86_s).
Out of Memory: Killed process 8355 (_18411Y85_s).
Out of Memory: Killed process 8414 (_18411Y87_s).
Out of Memory: Killed process 8453 (_18411Y86_s).
Out of Memory: Killed process 8478 (_18411Y8_10_s).
Out of Memory: Killed process 8480 (_18411Y45_s).
Out of Memory: Killed process 8545 (_18411Y87_s).
Out of Memory: Killed process 8586 (_18411Y46_s).
Out of Memory: Killed process 8645 (_18423Y11_s).

30d04 seems to be the same call to swap_free as before.

