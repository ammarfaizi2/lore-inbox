Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVCJTQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVCJTQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVCJTMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:12:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63648 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262778AbVCJTCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:02:46 -0500
Subject: Re: Can I get 200M contiguous physical memory?
From: Arjan van de Ven <arjan@infradead.org>
To: Nate Edel <mramfs@sfchat.org>
Cc: Jason Luo <abcd.bpmf@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <00b701c525a3$128c2ac0$6a004b0a@charlemagne>
References: <c4b38ec4050310001061c62b9d@mail.gmail.com>
	 <20050310081634.GA29516@taniwha.stupidest.org>
	 <c4b38ec40503100049190d5498@mail.gmail.com>
	 <1110445030.6291.57.camel@laptopd505.fenrus.org>
	 <00b701c525a3$128c2ac0$6a004b0a@charlemagne>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 20:02:36 +0100
Message-Id: <1110481356.6291.133.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 10:57 -0800, Nate Edel wrote:
> From: "Arjan van de Ven" <arjan@infradead.org>
> To: "Jason Luo" <abcd.bpmf@gmail.com>
> >> A data acquisition card. In DMA mode, the card need 200M contiguous
> >> memory for DMA.
> >
> > (or want to reserve memory at the boot commandline and then do really
> > really evil hacks)
> 
> Such as booting the machine with "mem=(real memory - 200)M" and then 
> just doing an ioremap of the top 200M of memory.
> 
> It's not the most elegant way of doing things given that it requires 
> user intervention at boot time, but I'm not sure it counts as a "really 
> evil hack."  

it really gets evil if your machine has > 4Gb of ram... then things
really go weird with this.


