Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271961AbRH2NOc>; Wed, 29 Aug 2001 09:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271962AbRH2NON>; Wed, 29 Aug 2001 09:14:13 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:52656 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271961AbRH2NOI> convert rfc822-to-8bit; Wed, 29 Aug 2001 09:14:08 -0400
Importance: Normal
Subject: Re: VM: Bad swap entry 0044cb00
To: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Cc: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF189FBE02.DCD70B2A-ONC1256AB7.0046D3BE@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Wed, 29 Aug 2001 15:14:43 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 29/08/2001 15:14:14
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



After some debug if think that the function which was called is:

zap_page_range

which inlines: zap_pmd_range
which inlines: zap_pte_range
which inlines: free_pte
which calls: swap_free
Adress 30d00 is part of the call to swap_free.



--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507


