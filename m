Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTI3TfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTI3TfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:35:19 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:34832 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261678AbTI3TfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:35:10 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <1064950495.4795.7.camel@localhost.localdomain>
From: Matt_Domsch@Dell.com
To: xose@wanadoo.es
cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br,
       atulm@lsil.com, linux-megaraid-devel@dell.com
Subject: RE: Megaraid does not work with 2.4.22
Date: Tue, 30 Sep 2003 14:34:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1367056C6436508-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are your plans to integrate the 1.18k as well as 2.00.9 megaraid
> drivers in the mainstream kernels.

I would be glad to see megaraid 1.18k and megaraid2 2.00.9 be included
in 2.4.x-stock.  These seem stable in our testing thus far.  Alan has
had megaraid2 2.00.(something - 5?) in his tree for a while now.

Alan didn't want to lightswitch the 1.18X series driver out during a
stable kernel series, preferring to have both a megaraid and a megaraid2
driver, and let people decide.


> Are they in 2.6 already? 

2.6.x has megaraid 2.00.3 in it right now - it needs to be brought up to
2.00.9.  There's no reason to have both megaraid and megaraid2 in 2.6.x,
only one 'megaraid' which is 2.00.x.


Atul should be submitting changelogs and patches to James Bottomley and
linux-scsi for inclusion in both 2.4.x and 2.6.x, unless Marcelo asks to
receive them directly.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

