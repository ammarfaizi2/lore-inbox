Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966384AbWKNVkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966384AbWKNVkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966385AbWKNVkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:40:13 -0500
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:56766 "EHLO
	smtp-7.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S966384AbWKNVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:40:11 -0500
Date: Tue, 14 Nov 2006 13:39:58 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: driver support for Chelsio T210 10Gb ethernet in 2.6.x
In-Reply-To: <20061114133304.36a01d0e@freekitty>
Message-ID: <Pine.LNX.4.64.0611141335280.3416@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0611131408010.32659@potato.cts.ucla.edu>
 <20061114133304.36a01d0e@freekitty>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, Stephen Hemminger wrote:
> On Tue, 14 Nov 2006 13:28:38 -0800 (PST) Chris Stromsoe 
> <cbs@cts.ucla.edu> wrote:
>
>> The in-kernel Chelsio cxgb driver in 2.6.19-rc5 is version 2.1.1 and 
>> only supports the N110 and N210 10Gb ethernet boards.  The current 
>> driver available from Chelsio[1] is 2.1.4a and supports the T110 and 
>> T210 series boards, but is only available against 2.6.16.  Any chance 
>> of an update to the in-kernel driver for 2.6.20 to support the T* 
>> series cards?
>
> Only if they don't try to put TOE support in.

To be honest, I haven't looked at the differences between the two drivers, 
other than note that 2.1.4a only builds against 2.6.16 and supports the T* 
cards.  The support download page (http://service.chelsio.com/drivers/) 
lists 2.1.4a as supporting the T* cards in "NIC mode" and has a separate 
driver (2.2.0) with TOE support.


-Chris
