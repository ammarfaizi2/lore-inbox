Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270498AbTHLPpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTHLPpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:45:54 -0400
Received: from mail.ccur.com ([208.248.32.212]:62476 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S270498AbTHLPpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:45:52 -0400
Date: Tue, 12 Aug 2003 11:45:36 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add an -Os config option
Message-ID: <20030812154535.GA5686@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20030811211145.GA569@fs.tum.de> <1060695341.21160.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060695341.21160.2.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 02:35:41PM +0100, Alan Cox wrote:
> On Llu, 2003-08-11 at 22:11, Adrian Bunk wrote:
>> +	  Enabling this option will pass "-Os" instead of "-O2" to gcc
>> +	  resulting in a smaller kernel.
>> +
>> +	  The resulting kernel might be significantly slower.
> 
> With most of the gcc's I tried -Os was faster.

Because of a better L1-instruction cache footprint?

Joe
