Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164366AbWLHBiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164366AbWLHBiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164367AbWLHBiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:38:18 -0500
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:53934 "EHLO
	serv1.oss.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164366AbWLHBiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:38:17 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>, linux-kernel@vger.kernel.org
In-Reply-To: <4578465D.7030104@cfl.rr.com>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
	 <4578465D.7030104@cfl.rr.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Fri, 08 Dec 2006 10:38:12 +0900
Message-Id: <1165541892.1063.0.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 11:50 -0500, Phillip Susi wrote:
> Marc Haber wrote:
> > I went back to 2.6.18.3 to debug this, and the system ran for three
> > days without problems and without corrupting
> > /var/cache/apt/pkgcache.bin. After booting 2.6.19 again, it took three
> > hours for the file corruption to show again.
> > 
> > I do not have an idea what could cause this other than the 2.6.19
> > kernel.
> <snip>
> > I'll happily deliver information that might be needed to nail down
> > this issue. Can anybody give advice about how to solve this?
> 
> I'd say start git bisecting to track down which commit the problem 
> starts at.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Does the patch below help?

http://marc.theaimsgroup.com/?l=linux-ext4&m=116483980823714&w=4

