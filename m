Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTKKVU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 16:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTKKVU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 16:20:26 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:21220 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263791AbTKKVUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 16:20:25 -0500
From: "Joseph Shamash" <info@avistor.com>
To: "Patrick Mansfield" <patmans@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, "Peter Chubb" <peter@chubb.wattle.id.au>,
       "Mike Fedyk" <mfedyk@matchmail.com>
Subject: RE: 2 TB partition support
Date: Tue, 11 Nov 2003 13:21:42 -0800
Message-ID: <HBEHKOEIIJKNLNAMLGAOGEDPDKAA.info@avistor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20031110213014.A2274@beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Patrick,

>The qlogic (qla2xxx) driver is not in the kernel,
>but is available for use with 2.6.

I have searched without success for this driver.
Qlogic tech support doesn't seem to know about it. 
Can you lead me to a link or provide this driver?

Thanks,
Joe
 


-----Original Message-----
From: Patrick Mansfield [mailto:patmans@us.ibm.com]
Sent: Monday, November 10, 2003 9:30 PM
To: Joseph Shamash
Cc: Mike Fedyk; Peter Chubb; linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support


On Mon, Nov 10, 2003 at 08:03:53PM -0800, Joseph Shamash wrote:

> The limitation we have found in 2.6 is lack FC HBA drivers which 
> are needed to support large storage capacities.
> 
> Any thoughts?

Please clarify "lack FC HBA drivers".

You mean no in kernel drivers? Yeh.

The qlogic (qla2xxx) driver is not in the kernel, but is available for use
with 2.6.

Martin Bligh included an emulex driver in his last 2.6 patch set.

-- Patrick Mansfield



