Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSHXSGv>; Sat, 24 Aug 2002 14:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSHXSGv>; Sat, 24 Aug 2002 14:06:51 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49925
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S316582AbSHXSGu>; Sat, 24 Aug 2002 14:06:50 -0400
Subject: Re: Preempt note in the logs
From: Robert Love <rml@tech9.net>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Arador <diegocg@teleline.es>, dag@newtech.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       conman@kolivas.net
In-Reply-To: <Pine.LNX.4.44.0208241157590.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0208241157590.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Aug 2002 14:11:03 -0400
Message-Id: <1030212663.861.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-24 at 14:01, Thunder from the hill wrote:

> Do you think it's useful to temporarily put a lock counter into struct 
> task (TEMPORARILY, Linus, temporarily!) and check that as well? Maybe that 
> will point us something.

There already is, it is called preempt_count.

> Or we should extend that whole crap a bit so we could see exactly what 
> caused the preemption count to rise. I don't know if we can do that, but 
> we can try doing that.

A lock trace would be helpful here.  But since I know normal kernel code
is not suspect, all these users need to do is find which oddball module
or patch they are using... e.g. watch it be nvidia.

	Robert Love

