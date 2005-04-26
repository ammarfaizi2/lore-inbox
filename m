Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVDZQ2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVDZQ2G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDZQZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:25:03 -0400
Received: from scrat.hensema.net ([62.212.82.150]:21435 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S261657AbVDZQW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:22:58 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: filesystem transactions API
Date: Tue, 26 Apr 2005 16:22:54 +0000 (UTC)
Message-ID: <slrnd6sqmu.rvc.erik@bender.home.hensema.net>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva (v@iki.fi) wrote:
> Apparently, Windows Longhorn will include something called "transactional
> NTFS". It's explained pretty well in
>
>    http://blogs.msdn.com/because_we_can/
>
> Basically, a process can create a fs transaction, and all fs changes made
> between start of the transaction and commit are atomical - meaning nothing
> is visible until commit, and if commit fails, everything is rolled back.
>
> Sound useful... Although there are no service pack installs that could fail
> in Linux, the same thing could be useful in rpm, yum, almost anything. 
>
> What do you think?

Doesn't reiser4 do this?

-- 
Erik Hensema <erik@hensema.net>
