Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRCMQmX>; Tue, 13 Mar 2001 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCMQmO>; Tue, 13 Mar 2001 11:42:14 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:21258 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131133AbRCMQmB>;
	Tue, 13 Mar 2001 11:42:01 -0500
Date: Tue, 13 Mar 2001 17:41:26 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux 2.4.2ac20
To: faceprint@faceprint.com
Cc: linux-kernel@vger.kernel.org
Message-id: <3AAE4DB6.8349ACBA@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Walp (faceprint@faceprint.com) wrote :

> Also, sometime between ac7 and ac18 (spring break kept me from testing 
> stuff inbetween), i assume during the new aic7xxx driver merge, the 
> order of detection got changed, and now the ide-scsi virtual host is 
> host0, and my 29160N is host1. Is this on purpose? It messed up a 
> bunch of my stuff as far as /dev and such are concerned. 

SCSI adapters are enumerated randomly(*) , relying on certain numbering
will get you into trouble, sooner or later.
There is no commonly accepted solution, AFAIK.
The same thing can happent to disk enumeration ( sdb becomes sdc )
or partition enumeration ( hda6 becomes hda5 ).

* - theoreticaly no, but practicaly yes ( most of the time )

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
