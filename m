Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWGNSpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWGNSpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbWGNSpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:45:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161038AbWGNSpd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:45:33 -0400
Date: Fri, 14 Jul 2006 11:18:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Q+lkcmlj?= Augonnet <Cedric.Augonnet@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
Message-Id: <20060714111804.39af438a.akpm@osdl.org>
In-Reply-To: <44B7DB25.4050905@ens-lyon.fr>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<44B7DB25.4050905@ens-lyon.fr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 19:57:57 +0200
Cédric Augonnet <Cedric.Augonnet@ens-lyon.fr> wrote:

> 
> I got this bug and this oops when booting with my USB hard-drive plugged 
> (it was not in mm1).  I also have the same problem when hot-plugging it. 
> And there is no oops at all without this USB hard-drive. Here is what 
> appears in my dmesg, and I join my .config.

yup, sorry. 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/hot-fixes/drivers-base-check-errors-fix.patch
should fix it.
