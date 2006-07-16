Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWGPSDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWGPSDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 14:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWGPSDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 14:03:25 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:39320 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S1750728AbWGPSDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 14:03:24 -0400
From: "Gary Funck" <gary@intrepid.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Yuri van Oers" <yvanoers@xs4all.nl>
Subject: RE: SCSI device order changed
Date: Sun, 16 Jul 2006 11:03:30 -0700
Message-ID: <JCEPIPKHCJGDMPOHDOIGOEKNDFAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060716171547.W18821-100000@xs3.xs4all.nl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-Spam-Score: -1.44 () ALL_TRUSTED
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuri van Oers wrote:
> I found a related post here: http://lkml.org/lkml/2005/12/3/192
> which suggests this situation arose around 2.6.15. It also says ordering
> can't be guaranteed. If that's the final verdict, I'll simply swap the
> cards on the PCI bus and be done with it.
> 

We saw this change in behavior also.  Labeling the root volume, and
mounting via label may help to keep things more portable, however,
I recall that labels and the device manager managed devices interacted
in some way that made mounting / via a label more difficult, however.
