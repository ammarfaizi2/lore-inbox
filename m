Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVBRGkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVBRGkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 01:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBRGkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 01:40:47 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:21252 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261208AbVBRGkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 01:40:41 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Chuck Berg <chuck@encinc.com>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord stuck in D state with USB DVD burner
Date: Fri, 18 Feb 2005 08:40:20 +0200
User-Agent: KMail/1.5.4
References: <20050218002141.GA7760@encinc.com>
In-Reply-To: <20050218002141.GA7760@encinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502180840.20037.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2005 02:21, Chuck Berg wrote:
> I have a system with two USB DVD burners. If I burn a disc on both at the
> same time, one of the dvdrecord processes hangs (unkillably stuck in the
> D state). The usb-storage kernel thread was also stuck in the D state.
> 
> I power-cycled both burners. The disconnect appeared in the logs but
> they were not detected when I powered them back on. After this, khubd
> and scsi_eh_12 kernel threads were stuck in the D state.
> 
> This is with kernel 2.6.11-rc4. Fedora's 2.6.10-1.766_FC3smp also has the
> same problem.
> 
> This is repeatable. I have no trouble if I only write to one drive at a time.

I used to send this to LKML periodically:

Sending bug report/patch:
=========================
* Some device drivers have active developers, try to contact them first.
* Otherwise find a subsystem maintainer to which your report pertains
  and send report to his address.
* Small fixes and device driver updates are best directed to subsystem
  maintainers and "small bits" integrators.
* It never hurts to CC: Linux kernel mailing list, but without specific
  maintainer address in To: field there is high probability that your
  patch won't be noticed. You have been warned.
--
vda

