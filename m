Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271943AbRH2KsI>; Wed, 29 Aug 2001 06:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271945AbRH2Kr7>; Wed, 29 Aug 2001 06:47:59 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:18569 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S271943AbRH2Krs> convert rfc822-to-8bit; Wed, 29 Aug 2001 06:47:48 -0400
Importance: Normal
Subject: Re: VM: Bad swap entry 0044cb00
To: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Cc: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFC1BB9C0E.DA740D8A-ONC1256AB7.003AF644@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Wed, 29 Aug 2001 12:47:54 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 29/08/2001 12:47:20
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Hugh,

System.map:

000307c0 T copy_page_range
00030a9c T zap_page_range
00030da4 t follow_page
00030e70 T map_user_kiobuf

dmesg:

Out of Memory: Killed process 6667 (_18411Y45_s).
swap_free from 80030d00: Bad swap entry 0a2c2600
Out of Memory: Killed process 7374 (_18411Y46_s).
Out of Memory: Killed process 7401 (_18411Y85_s).
swap_free from 80030d00: Bad swap entry 0a0b0600
Out of Memory: Killed process 7589 (_18411Y86_s).
Out of Memory: Killed process 7611 (_18411Y47_s).
Out of Memory: Killed process 7778 (_18411Y48_s).
Out of Memory: Killed process 7791 (_18411Y87_s).
Out of Memory: Killed process 7804 (_18411Y45_s).
Out of Memory: Killed process 7935 (_18411Y8_10_s).
Out of Memory: Killed process 7957 (_18411Y46_s).
Out of Memory: Killed process 8077 (_18411Y85_s).
Out of Memory: Killed process 8154 (_18411Y47_s).
Out of Memory: Killed process 8154 (_18411Y47_s).

I will make do a listing of the kernel (S/390-assembler) of zap_page_range
and of possible find out the line of the C-Code.


Note: Don´t care about the 8 in front of the adress. That is
S/390-specific.

Thanks

--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507


