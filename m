Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWAaSeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWAaSeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWAaSeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:34:46 -0500
Received: from mail.gmx.de ([213.165.64.21]:35500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751329AbWAaSep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:34:45 -0500
X-Authenticated: #17209196
Date: Tue, 31 Jan 2006 19:34:43 +0100
From: "Gabriel C." <da.crew@gmx.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>,
       Adrian Bunk <bunk@stusta.de>, netdev@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4: ACX=y, ACX_USB=n compile error
Message-ID: <20060131193443.5822661b@zwerg>
In-Reply-To: <200601311658.09423.vda@ilport.com.ua>
References: <20060130133833.7b7a3f8e@zwerg>
	<200601311416.05397.vda@ilport.com.ua>
	<20060131145431.GI5433@tuxdriver.com>
	<200601311658.09423.vda@ilport.com.ua>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.8.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2006 16:58:09 +0200
Denis Vlasenko <vda@ilport.com.ua> wrote:

> On Tuesday 31 January 2006 16:54, John W. Linville wrote:
> > On Tue, Jan 31, 2006 at 02:16:05PM +0200, Denis Vlasenko wrote:
> > 
> > > CONFIG_ACX=y
> > > # CONFIG_ACX_PCI is not set
> > > # CONFIG_ACX_USB is not set
> > > 
> > > This won't fly. You must select at least one.
> > > 
> > > Attached patch will check for this and #error out.
> > > Andrew, do not apply to -mm, I'll send you bigger update today.
> > 
> > Is there any way to move this into a Kconfig file?  That seems nicer
> > than having #ifdefs in source code to check for a configuration
> > error.
> 
> Can't think of any at the moment.
> --
> vda
> 

I'm not a kernel hacker :-) and mabye I'm wrong but why not auto select
ACX_{PCI,USB} ?

Gabriel
