Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283719AbRLTKMU>; Thu, 20 Dec 2001 05:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283718AbRLTKMK>; Thu, 20 Dec 2001 05:12:10 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:51109 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S283675AbRLTKL7> convert rfc822-to-8bit;
	Thu, 20 Dec 2001 05:11:59 -0500
Message-ID: <F5FEAC407A690E42BD26E4F145301942AC64A1@esebe002.NOE.Nokia.com>
From: Mika.Liljeberg@nokia.com
To: davem@redhat.com, kuznet@ms2.inr.ac.ru
Cc: Mika.Liljeberg@welho.com, linux-kernel@vger.kernel.org
Subject: TCP with IPv6 always refuses timestamps
Date: Thu, 20 Dec 2001 12:11:44 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another bug found. TCP over IPv6 always seems to refuse the timestamps
option when responding to a SYN. When originating a connection, timestamps
work fine.

BR,

	MikaL

----------------------------------------------------------------
Mika Liljeberg            Phone:  +358 5048 36791
Nokia Research Center     Fax:    +358 7180 36850
P.O.Box 407               Email:  mika.liljeberg@nokia.com
FIN-00045 NOKIA GROUP     Office: Itämerenkatu 11-13,
Finland                           FIN-00180, Helsinki, Finland
----------------------------------------------------------------
