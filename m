Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbSJDSbX>; Fri, 4 Oct 2002 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbSJDSbX>; Fri, 4 Oct 2002 14:31:23 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:9982 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261798AbSJDSbX>; Fri, 4 Oct 2002 14:31:23 -0400
Subject: Re: 3DNOW Question/MMX Support in 2.4.X tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021004121543.A29145@vger.timpanogas.org>
References: <20021004121543.A29145@vger.timpanogas.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 19:45:27 +0100
Message-Id: <1033757127.31839.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 20:15, Jeff V. Merkey wrote:
> I noticed that the MMX libraries seem tied to CYRIX and AMD builds 
> in the config scripts.  I am wondering if MMX support for Intel 
> is not supported in 2.4.X kernels except for these processor types.
> The code appears to be usable on Intel.

MMX copies are only a win on some processors, so we only use it in
kernel there. MMX itself works on all processors

