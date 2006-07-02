Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWGBRwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWGBRwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWGBRwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:52:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932708AbWGBRwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:52:37 -0400
Subject: Re: 2.6.17-mm5 -- Busted toolchain? --
	usr/klibc/exec_l.c:59:	undefined reference to `__stack_chk_fail'
From: Arjan van de Ven <arjan@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151862632.3111.25.camel@laptopd505.fenrus.org>
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
	 <1151826131.3111.5.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com>
	 <1151861523.3111.19.camel@laptopd505.fenrus.org>
	 <44A80471.1020406@zytor.com>
	 <1151862632.3111.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 19:52:31 +0200
Message-Id: <1151862752.3111.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 19:50 +0200, Arjan van de Ven wrote:
> On Sun, 2006-07-02 at 10:37 -0700, H. Peter Anvin wrote:
> > Arjan van de Ven wrote:
> > > 
> > >> Does this mean that you don't want to see these fno-stack-protector
> > >> patches go into Andrew's tree?
> > > 
> > > long term.. no. Because I want to enable stack-protector for the kernel
> > > (I have patches for that; all it needs is a 5 line gcc patch to make it
> > > work) as debug option at least (and if the perf impact isn't too bad,
> > > distros and security sensitive people can enable it always). 
> > > 
> > 
> > Obviously, but at that time we should enable -fno-stack-protector vs 
> 
> -fno-stack-protector doesn't even exist afaics;

ok it does; I just tested on the wrong machine 
sorry


