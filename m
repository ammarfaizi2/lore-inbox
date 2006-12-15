Return-Path: <linux-kernel-owner+w=401wt.eu-S1752955AbWLORNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbWLORNw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbWLORNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:13:52 -0500
Received: from mail.tmr.com ([64.65.253.246]:54211 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbWLORNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:13:52 -0500
Message-ID: <4582D8CE.7000304@tmr.com>
Date: Fri, 15 Dec 2006 12:18:06 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>,
       jens.axboe@oracle.com
Subject: Re: 2.6.19 kernel series, SATA, wodim (cd recording), synaptics 
  update,
References: <4581559d.iqe9L1/wj2D5j93L%Joerg.Schilling@fokus.fraunhofer.de>
In-Reply-To: <4581559d.iqe9L1/wj2D5j93L%Joerg.Schilling@fokus.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
>> CD recording : recorder no longer detected by "wodim" software set in
>> 2.6.19.   I suspect it's a bug in the software...  but don't know where
>> to look for changes.   2.6.19-rc5 worked.
>> hardware: IDE MATSHITADVD-RAM UJ-820S
>> (2.6.19-git6 also fails with external LiteON USB DVD burner)
> 
> I recommend to check the latest cdrtools packet from:
> 
> ftp://ftp.berlios.de/pub/cdrecord/alpha/
> 
> At the same place, there is a patch for recent Linux systems
> that allows cdrecord to sense the MAX DMA size for USB.

Jens, any comment on this? DMA size limitations could be useful to other 
programs as well.
> 
> Do not use cdrecord derivates but the original as derivates may have bugs
> that are not present in the original.

That cuts both ways.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
