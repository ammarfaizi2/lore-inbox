Return-Path: <linux-kernel-owner+w=401wt.eu-S1752761AbWLOPxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbWLOPxZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbWLOPxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:53:24 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:37889 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752761AbWLOPxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:53:24 -0500
Message-ID: <4582C4FC.8040203@cfl.rr.com>
Date: Fri, 15 Dec 2006 10:53:32 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: interface for modems with out of band signalling
References: <200612151514.00390.oliver@neukum.org>
In-Reply-To: <200612151514.00390.oliver@neukum.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2006 15:53:33.0042 (UTC) FILETIME=[2C4BA520:01C72061]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14874.003
X-TM-AS-Result: No--12.466900-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Hi,
> 
> I have got a question about modems which use the AT command set, but
> don't use in band signalling like true rs232 modems. Would two device nodes
> per communication channel be a good interface?

Huh?  What do you mean "don't use in band signaling"?  If you are asking 
how you issue AT commands to the modem while connected, you have to 
break to command mode.  IIRC, this involves sending a special break 
character or two with the correct delay between them, or flipping one of 
the RS232 handshake lines.


