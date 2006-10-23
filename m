Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWJWLHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWJWLHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWJWLHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:07:14 -0400
Received: from web32402.mail.mud.yahoo.com ([68.142.207.195]:26246 "HELO
	web32402.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751900AbWJWLHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:07:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AiTQfGRA1FCX0N2TXr26eJx0zGJ+hIGQGxF/WzGg6K3j8bhovRxrIpW9lEioHC5QV5AuA+PqqNtTKdCtouRjRaNYfF2PL912dh55gklwq5oGpZ+ECg88IwrgK/UxLHPwjQosjP5KLpucutfWKi5ZNk82imZNOBRtGiN0YHoiRyY=  ;
Message-ID: <20061023110712.41162.qmail@web32402.mail.mud.yahoo.com>
Date: Mon, 23 Oct 2006 04:07:12 -0700 (PDT)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: incorrect taint of ndiswrapper
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200610230212.49298.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Chase Venters <chase.venters@clientec.com> wrote:

> Next question - what version of ndiswrapper started voluntary tainting (or
> has 
> it always?)
> 
> That is to say, are there versions of ndiswrapper floating around out there
> in 
> the ether capable of building against 2.6.19-rc* that don't voluntarily 
> add_taint()? (I'm guessing the answer is 'no', but the answer is possibly 
> important to consider)

Since version 1.0, ndiswrapper has been tainting kernel when a driver is
loaded. Version 1.0 is quite old (circa Jan 2005) and won't build with any
recent kernels.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
