Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWHXK2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWHXK2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWHXK2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:28:49 -0400
Received: from asp.isprit2.de ([213.221.110.57]:54243 "EHLO
	prod-tx-2.isprit2.de") by vger.kernel.org with ESMTP
	id S1751040AbWHXK2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:28:48 -0400
Subject: Re: Kernel 2.6.17.8 on Quad AMD Opteron 852 with 16x 4GB Modules
	(64GB RAM)
From: Maciek Zobniow <maciej.zobniow@xq11.com>
Reply-To: maciej.zobniow@xq11.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Organization: XQueue GmbH
Date: Thu, 24 Aug 2006 12:30:47 +0200
Message-Id: <1156415447.4889.14.camel@Maciek.xqueue.qu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Björn Engelhardt wrote:
>> Hello,
>> 
>> we upgraded a Server from 32 GB RAM to 64 GB. Now we try to get a Linux 
>> (FC5) with kernel 2.6.17.8 on a Quad Opteron (852; 64bit)-system with 
>> 16x 4GB modules to run.
>> With 32 GB (8x 4GB modules) the system starts without any problems, but 
>> above I get kernelpanics.
>> The output then gives me several memoryaddresses bevore the panic 
>> appears. The board (a Tyan K8QW,model S4881) should support up to 64GB 
>> Ram. A Memorytest under Linux recognizes the 64GB and continues without 
>> an error.
>> I tried several BIOS-Settings.
>> Does the kernel support the new 4GB-Modules by 64GB Ram?
>> 
>
>Sounds like your memory is bad.
>
>	-hpa

My friend Bjoern has forgotten to write that we actually checked the memory with only 32GB and kernel booted normally. 
The problem appears when we want to put more, even just next 4GB, over the 32GB. It seems to be a kernel problem to me. 
Will try to retrive and send oops tonight.

Thanks for any suggestion!

Regards
Maciek  

