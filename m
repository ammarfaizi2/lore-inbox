Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVE3AGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVE3AGT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVE3AGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:06:19 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:31762 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261471AbVE3AGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:06:15 -0400
Message-ID: <429A58F4.3040308@rtr.ca>
Date: Sun, 29 May 2005 20:06:12 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com> <1117387591.4851.17.camel@localhost.localdomain>
In-Reply-To: <1117387591.4851.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
>
> ICH6M (mobile/no raid) on a Dell Inspiron 9300 laptop. AFAIK there are
> no plans to implement support for AHCI transition in the BIOS. &^$##($%
> DELL.

No hope of it on this machine (I'm using a tricked-out i9300 here too),
because (1) the HD is PATA, not SATA, and (2) the drive itself probably
doesn't support NCQ (my 100GB drive does NOT -- use "hdparm -I" to see
what is supported on any given drive.  libata-dev includes hdparm support).

Cheers
