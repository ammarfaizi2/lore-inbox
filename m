Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWAaRaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWAaRaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWAaRaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:30:20 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24541 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751296AbWAaRaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:30:19 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.16-rc1-mm4: ACX=y, ACX_USB=n compile error
Date: Tue, 31 Jan 2006 16:58:09 +0200
User-Agent: KMail/1.8.2
Cc: "Gabriel C." <crazy@pimpmylinux.org>, da.crew@gmx.net,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       netdev@vger.kernel.org
References: <20060130133833.7b7a3f8e@zwerg> <200601311416.05397.vda@ilport.com.ua> <20060131145431.GI5433@tuxdriver.com>
In-Reply-To: <20060131145431.GI5433@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601311658.09423.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 16:54, John W. Linville wrote:
> On Tue, Jan 31, 2006 at 02:16:05PM +0200, Denis Vlasenko wrote:
> 
> > CONFIG_ACX=y
> > # CONFIG_ACX_PCI is not set
> > # CONFIG_ACX_USB is not set
> > 
> > This won't fly. You must select at least one.
> > 
> > Attached patch will check for this and #error out.
> > Andrew, do not apply to -mm, I'll send you bigger update today.
> 
> Is there any way to move this into a Kconfig file?  That seems nicer
> than having #ifdefs in source code to check for a configuration error.

Can't think of any at the moment.
--
vda
