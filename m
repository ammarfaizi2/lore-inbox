Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWBLWq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWBLWq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 17:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWBLWq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 17:46:59 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:41998 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751485AbWBLWq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 17:46:58 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC: 2.6 patch] CONFIG_FORCEDETH updates
Date: Sun, 12 Feb 2006 22:47:01 +0000
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060212175202.GK30922@stusta.de> <1139781817.19342.300.camel@mindpipe>
In-Reply-To: <1139781817.19342.300.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602122247.01478.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 February 2006 22:03, Lee Revell wrote:
> On Sun, 2006-02-12 at 18:52 +0100, Adrian Bunk wrote:
> > This patch contains the following possible updates:
> > - let FORCEDETH no longer depend on EXPERIMENTAL
> > - remove the "Reverse Engineered" from the option text:
> >   for the user it's important which hardware the driver supports, not
> >   how it was developed
>
> Is this driver as stable as one that was developed with proper
> documentation?  I prefer to know that something as elementary as a fast
> ethernet controller had to be reverse engineered so I can avoid
> supporting a vendor so hostile to Linux.

Although NVIDIA continue to maintain their own driver, I know forcedeth has 
had contributions from at least a couple of NVIDIA employees. Also, I've 
personally used the driver on nForce2, nForce3 and now nForce4 SLI boards and 
it's rock solid.

Adrian's change is a good one, IMO.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
