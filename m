Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTDPPVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264556AbTDPPVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:21:17 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:41476 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S264553AbTDPPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:21:14 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D127@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'hps@intermeta.de'" <hps@intermeta.de>, linux-kernel@vger.kernel.org
Subject: RE: [2.4.21-pre7-ac1] IDE Warning when booting
Date: Wed, 16 Apr 2003 09:32:48 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the quantum bigfoot doesn't support setting the multiple block size?

Hrm, how old is that disk?  SET MULTIPLE MODE has been an ATA standard
command since rev 3 of the spec, circa 1997...

I guess that is what Alan meant when he said people throw everything at
linux hardware wise...

--eric


> -----Original Message-----
> From: Henning P. Schmiedehausen [mailto:hps@intermeta.de]
> Sent: Wednesday, April 16, 2003 5:17 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: [2.4.21-pre7-ac1] IDE Warning when booting
> 
> Alan did post an explanation for these (which I haven't read before
> posting this) that these are harmless. And yes, the task_no_data_intr
> vs. set_multmode makes all the difference. :-) Getting these quieted
> down would be nice, though.
> 
> 	Regards
> 		Henning
