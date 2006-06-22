Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWFVEUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWFVEUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbWFVEUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:20:15 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:19654 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932781AbWFVEUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:20:13 -0400
X-Sasl-enc: XwXUUo7pkSCHyQDE89yBw0mpCqyNLhiaQepEU0OcPYaB 1150950011
Message-ID: <09be01c695b3$2ed8c2c0$c100a8c0@robm>
From: "Robert Mueller" <robm@fastmail.fm>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@digeo.com>, "Dax Kelson" <dax@gurulabs.com>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Bron Gondwana" <brong@fastmail.fm>, "erich" <erich@areca.com.tw>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Areca driver recap + status
Date: Thu, 22 Jun 2006 14:18:23 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As happy users of areca raid cards, we're keen to see a stable driver make 
it into the next kernel release. I thought I might quickly recap what's 
happened with the driver over the last 6 months to see where things are at:

The driver went into 2.6.11-rc3-mm1 here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110754432622498&w=2

A thread about overall style + api problems here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113525798005993&w=2

Some specific comments + patches from Randy and Chris about problems:
http://marc.theaimsgroup.com/?l=linux-scsi&m=113597128115672&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=114045972531035&w=2

An update from erich went into 2.6.16-rc6-mm2 to address a number of the 
problems:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114282535310724&w=2

End of thread about problem ARCMSR_MAX_XFER_SECTORS of 4096 vs 512:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114602195422443&w=2

Comment from Andrew about helping to get the driver in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114945466405532&w=2

Though there did still seem to be quite a few things missing:
http://marc.theaimsgroup.com/?l=linux-scsi&m=114556263632510&w=2

General comment on areca driver is "improving", we seem to need a sound 
"todo" list:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114949920416720&w=2

Some of those remaining problems seem pretty serious concerns, though I 
don't really know any of the technical details. The latest driver from -mm 
seems to be working well for us at the moment. Is the general concensus that 
the driver should go in despite these issues, and they can be fixed over 
time? Or are these still show stoppers?

Thanks

Rob

