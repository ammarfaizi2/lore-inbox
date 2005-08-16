Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVHPX3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVHPX3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVHPX3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:29:32 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:44349 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbVHPX3c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:29:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rBsu3oQ8m3rwdJePGSXAuO2UuY2RemrKfrkCOUO9uflg4UZFllZ2Il0dWiYezX5usXEjmeezM9rknBC0TcX3vLoHb1bwzyFK71KzytX5BZA3KL/yWYAZ3oj+WtS7bkUJMlNdvWkt38L+00U1BPHcm1nyGjyXttRYQovGbWLS2Gc=
Message-ID: <253818670508161629165e3811@mail.gmail.com>
Date: Tue, 16 Aug 2005 19:29:28 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: abonilla@linuxwireless.org
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <1124234133.4855.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1124205914.4855.14.camel@localhost.localdomain>
	 <20050816200708.GE3425@suse.de>
	 <1124234133.4855.73.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, Alejandro Bonilla Beeche <abonilla@linuxwireless.org> wrote:
> On Tue, 2005-08-16 at 22:07 +0200, Jens Axboe wrote:
> > On Tue, Aug 16 2005, Alejandro Bonilla Beeche wrote:
> > If I were in your position, I would just implement this for ide (pata,
> > not sata) right now, since that is what you need to support (or do some
> > of these notebooks come with sata?). So it follows that you add an ide
> 
> Some notebooks are coming up with a Sata controller I think, but is
> still and IDE drive. I think some T43's come with that.
> 
> But, I will ask or check again later if we ever need this feature for
> SATA.

I believe T43s use a SATA->PATA bridge for their hard drives, so we
probably would.

(see http://www.thinkwiki.org/wiki/Category_talk:T43).

Yani
