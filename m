Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934114AbWKWV4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934114AbWKWV4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933936AbWKWV4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:56:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50617 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933938AbWKWV4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:56:20 -0500
Message-ID: <456618F8.5070000@pobox.com>
Date: Thu, 23 Nov 2006 16:56:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jason Gaston <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
References: <1164149498.27730.17.camel@localhost.localdomain> <1164186260.31358.717.camel@laptopd505.fenrus.org>
In-Reply-To: <1164186260.31358.717.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-11-21 at 14:51 -0800, Jason Gaston wrote:
>> This patch adds the Intel ICH9 AHCI controller DID's for SATA support.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> there was some discussion about a generic class match for ahci...
> would these devices be matched by that?

AHCI class yes, RAID class no.

But vendors would probably /love/ that we didn't match the RAID class, 
even though we can drive it...

	Jeff



