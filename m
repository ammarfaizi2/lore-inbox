Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTFXTxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 15:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFXTxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 15:53:18 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:4613 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261188AbTFXTxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 15:53:18 -0400
Subject: Re: Large backwards time steps panic 2.5.73
From: James Bottomley <James.Bottomley@steeleye.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1056484203.1033.192.camel@w-jstultz2.beaverton.ibm.com>
References: <1056472020.2085.81.camel@mulgrave> 
	<1056484203.1033.192.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Jun 2003 15:07:16 -0500
Message-Id: <1056485244.1825.173.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 14:50, john stultz wrote:
> On Tue, 2003-06-24 at 09:26, James Bottomley wrote:
> > The above trace is from a HP PA-RISC machine running 2.5.73-pa1.
> 
> Hmm. Odd. What is the HZ frequency on this machine? 

On the kernel with the panic, 100.  If I build a 64 bit kernel (which I
haven't done for .73 yet) I'll get 1000

James



