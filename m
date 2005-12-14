Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVLNBeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVLNBeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVLNBeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:34:07 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:9079 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030352AbVLNBeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:34:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm1
Date: Tue, 13 Dec 2005 20:33:51 -0500
User-Agent: KMail/1.9.1
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
References: <20051204232153.258cd554.akpm@osdl.org> <20051214011738.6c05dc1f@werewolf.auna.net> <20051213162259.5826939a.akpm@osdl.org>
In-Reply-To: <20051213162259.5826939a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512132033.52129.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 19:22, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On Tue, 13 Dec 2005 15:24:50 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > "J.A. Magallon" <jamagallon@able.es> wrote:
> > > >
> > > > On Sun, 4 Dec 2005 23:21:53 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > > > 
> > > > > 
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> > > > > 
> > > > 
> > > > mmm, this patch GPL'ed all pci_xxxxxx functions, so it broke what you
> > > > all know.
> > > 
> > > That'll be gregkh-pci-shot-accross-the-bow.patch.
> > > 
> > > > Final attack against binary drivers ? Or just an API change ?
> > > 
> > > A joke, I believe.
> > 
> > :))
> > Thanks.
> > 
> > BTW, is there any easy way to get a reverse patch, apart from patch -R
> > and rediff ?
> 
> That's the easiest (only?) way...
>

interdiff original.patch /dev/null > reversed.patch

-- 
Dmitry
