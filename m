Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269189AbUINHnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269189AbUINHnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUINHnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:43:31 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:29641 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S269189AbUINHnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:43:25 -0400
Subject: Re: segfault and multiple traps on x86_64
From: Alexander Nyberg <alexn@dsv.su.se>
To: Leonid Kalmankin <lvk@mashcenter.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040914013117.3bda812d.lvk@mashcenter.ru>
References: <20040914013117.3bda812d.lvk@mashcenter.ru>
Content-Type: text/plain
Message-Id: <1095147803.701.3.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 09:43:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 23:31, Leonid Kalmankin wrote:
> Greetings!
> 
> In dmesg I see stuff like:
> 
> rpmbuild[3842] trap int3 rip:402d9e rsp:7fbfffb540 error:0
> rpmbuild[3842] trap int3 rip:4026d1 rsp:7fbfffb538 error:0
> sh[3843] trap int3 rip:415f39 rsp:7fbffff8c8 error:0
> sh[3843]: segfault at 0000000000000000 rip 0000000000000000 rsp 0000007fbffff8b8 error 14
> rpmbuild[3842] trap int3 rip:402dea rsp:7fbfffb540 error:0
> rpmbuild[3842] trap int3 rip:4025d1 rsp:7fbfffb538 error:0
> rpmbuild[3842] trap int3 rip:402ced rsp:7fbfffb540 error:0
> rpmbuild[3842] trap int3 rip:4027c1 rsp:7fbffff688 error:0
> 

They just chose to show a small message in the log when some program
behaves badly. Nothing to worry about, more than your programs
misbehaving.

Alex

