Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWAaGLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWAaGLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWAaGLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:11:41 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43153 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932379AbWAaGLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:11:40 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc1-mm4: ACX=y, ACX_USB=n compile error
Date: Tue, 31 Jan 2006 08:10:32 +0200
User-Agent: KMail/1.8.2
Cc: "Gabriel C." <crazy@pimpmylinux.org>, linville@tuxdriver.com,
       linux-kernel@vger.kernel.org, da.crew@gmx.net, netdev@vger.kernel.org
References: <20060130133833.7b7a3f8e@zwerg> <20060130181039.GC3655@stusta.de>
In-Reply-To: <20060130181039.GC3655@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601310810.33107.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 20:10, Adrian Bunk wrote:
> On Mon, Jan 30, 2006 at 01:38:33PM +0100, Gabriel C. wrote:
> 
> > Hello,
> 
> Hi Gabriel,
> 
> > I got this compile error with 2.6.16-rc1-mm4 , config attached. 
> > 
> > 
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o: In function
> > `acx_l_transmit_authen1':common.c:(.text+0x6cd62): undefined reference
> > to `acxusb_l_alloc_tx' :common.c:(.text+0x6cd74): undefined reference
> > to `acxusb_l_get_txbuf' :common.c:(.text+0x6cdeb): undefined reference
> > to `acxusb_l_tx_data' drivers/built-in.o: In function
> > `acx_s_configure_debug': undefined reference to
> > `acxusb_s_issue_cmd_timeo_debug' drivers/built-in.o: In function
> > [many more]
> >...
> 
> Thanks for your report.
> 
> @Denis:
> The problem seems to be CONFIG_ACX=y, CONFIG_ACX_USB=n.

Thanks, will test/fix ASAP.

Gabriel, please send me your .config
--
vda
