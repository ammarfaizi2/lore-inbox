Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVCRPz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVCRPz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVCRPz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:55:57 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:54546 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261662AbVCRPzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:55:37 -0500
Date: Fri, 18 Mar 2005 10:55:01 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Hong Kong Phoey <hongkongphoey@gmail.com>,
       Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DM9000 network driver
Message-ID: <20050318155459.GB9136@tuxdriver.com>
Mail-Followup-To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Hong Kong Phoey <hongkongphoey@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20050318133143.GA20838@metis.extern.pengutronix.de> <4f6c1bdf0503180711148b8f02@mail.gmail.com> <20050318152554.GH17865@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318152554.GH17865@csclub.uwaterloo.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 10:25:54AM -0500, Lennart Sorensen wrote:
> On Fri, Mar 18, 2005 at 08:41:52PM +0530, Hong Kong Phoey wrote:

> > switch(foo) {
> > 
> >   case 1:
> >              f1();
> >   case2 :
> >              f2();
> > };
> > 
> > could well become
> > 
> > void (*func)[] = { f1, f2 };
> > 
> > func(i);
> 
> Ewww!

My thoughts exactly...there might be a place for something like that,
but I don't think this is it...

John
-- 
John W. Linville
linville@tuxdriver.com
