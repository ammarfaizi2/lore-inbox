Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRDCQKW>; Tue, 3 Apr 2001 12:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbRDCQKM>; Tue, 3 Apr 2001 12:10:12 -0400
Received: from web5203.mail.yahoo.com ([216.115.106.97]:50706 "HELO
	web5203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132186AbRDCQKA>; Tue, 3 Apr 2001 12:10:00 -0400
Message-ID: <20010403160919.14357.qmail@web5203.mail.yahoo.com>
Date: Tue, 3 Apr 2001 09:09:19 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: SIS 5513/IBM Deskstar HDIO_SET_DMA Operation not permitted?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2 allowed me to set DMA on an SIS 5513 using an IBM
Deskstar 40 gig IDE.  2.4 goes "Operation not
permitted" when I try it.

Why?

I hit it with ide0=ata66 in lilo, and it sped up from
3 megs/sec to 5 megs/second, but I used to get 12. 
hdparm /dev/hda still says I'm not using DMA.

I realise I'm doing dangerous stuff here to get the
performance back.  I'm just curious why it's not doing
it for me.  (Is there a known problem I should be
worried about?)

Let's see, ide0=dma,ata66...  right?  Should I be
really really worried about my data integrity if I do
this?  It never had a problem under 2.2...

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
