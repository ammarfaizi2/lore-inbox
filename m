Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318920AbSIIVsa>; Mon, 9 Sep 2002 17:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318941AbSIIVsa>; Mon, 9 Sep 2002 17:48:30 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:15344
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318920AbSIIVs3>; Mon, 9 Sep 2002 17:48:29 -0400
Subject: RE: Calculating kernel logical address ..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: imran.badr@cavium.com
Cc: root@chaos.analogic.com, "'David S. Miller'" <davem@redhat.com>,
       phillips@arcor.de, linux-kernel@vger.kernel.org
In-Reply-To: <01a301c2582c$754dbf30$9e10a8c0@IMRANPC>
References: <01a301c2582c$754dbf30$9e10a8c0@IMRANPC>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 22:55:26 +0100
Message-Id: <1031608526.29792.77.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 19:12, Imran Badr wrote:
> But my question here still begging an answer: What would be the portable way
> to calculate kernel logical address of that user buffer?

Who says it even has one ? Not all user allocated pages are even mapped
into the kernel by default. The kiobuf stuff used in 2.4 will do the job
for 2.4. For 2.5 the API will probably look a little different and be a
fair bit faster

