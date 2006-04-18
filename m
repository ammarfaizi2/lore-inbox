Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDRJfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDRJfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWDRJfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:35:23 -0400
Received: from web52610.mail.yahoo.com ([206.190.48.213]:64636 "HELO
	web52610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750704AbWDRJfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:35:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l9Z92YACw0HvG+Yp8z09DO8sNcXDqmExllf7MQgQUND3ck94EH78Fr/7dsOfrX6locEMWgyinf1iv8xR86khyv+zGUBCJGec8RklfACgzF+2CiK3fnuzCGzN301QnHyOLoFoB7MLoGir2EyPbyslTZ5IoqjffHwk8OHFyoveV4w=  ;
Message-ID: <20060418093521.41424.qmail@web52610.mail.yahoo.com>
Date: Tue, 18 Apr 2006 19:35:21 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.16.1 & D state processes
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1145341823.9243.10.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Mike Galbraith <efault@gmx.de> wrote:
> On Tue, 2006-04-18 at 15:07 +1000, Srihari
> Vijayaraghavan wrote:
> > io scheduler cfq registered (default)
> ...
> Hmm.  Recovers [odd] but takes long time [odder]. 
> I'd try to eliminate
> io scheduler at this point.

Interesting. Considering the minimal .config, where I
haven't experienced this problem over a week uptime,
also having CFQ as the default elevator, do you still
believe CFQ is involved? (I guess if CFQ could be
influenced by other kernel configurations, then
perhaps another elevator might help. It's worth
trying.)

I'm on 2.6.16.7 full config now. I'll try a few
things, if I were to observe problems:
1. Use deadline elevator
2. Start eliminating a few kernel configurations to
narrow it down

Thanks 

Send instant messages to your online friends http://au.messenger.yahoo.com 
