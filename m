Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWCDAHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWCDAHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWCDAHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:07:49 -0500
Received: from cantor.suse.de ([195.135.220.2]:17842 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751765AbWCDAHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:07:48 -0500
From: Andi Kleen <ak@suse.de>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Sat, 4 Mar 2006 01:07:26 +0100
User-Agent: KMail/1.8
Cc: Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com>
In-Reply-To: <20060303234330.GA14401@ti64.telemetry-investments.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603040107.27639.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 March 2006 00:43, Bill Rugolsky Jr. wrote:

> I built 2.6.16-rc5-git6 yesterday, and it still suffers from the same
> issue.

FWIW i looked over sata_nv and libata-{core,scsi} and I couldn't find
any obviously unmatched irqsave/irqrestore. So it would need instrumentation.

In theory it could be also hardware i suppose.

-Andi
