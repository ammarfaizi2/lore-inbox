Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWIKRXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWIKRXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWIKRXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:23:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751235AbWIKRXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:23:34 -0400
Date: Mon, 11 Sep 2006 10:23:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060911102328.861a64b3.akpm@osdl.org>
In-Reply-To: <200609110842_MC3-1-CAD5-5E82@compuserve.com>
References: <200609110842_MC3-1-CAD5-5E82@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 08:41:02 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <20060910221421.1aeac3c9.akpm@osdl.org>
> 
> On Sun, 10 Sep 2006 22:14:21 -0700, Andrew Morton wrote:
> 
> > > Patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch does not apply (enforce with -f)
> >
> > It works for me - I expect your tree is out of sync.
> 
> Well something is out of sync but I don't think it's me.

Beats me, sorry.

wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.18-rc6.tar.bz2
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/2.6.18-rc6-mm1-broken-out.tar.gz
box:/home/akpm> mkdir aa
box:/home/akpm> cd aa
box:/home/akpm/aa> tar xfj ../linux-2.6.18-rc6.tar.bz2 
box:/home/akpm/aa> cd linux-2.6.18-rc6 
box:/home/akpm/aa/linux-2.6.18-rc6> tar xfz ../../2.6.18-rc6-mm1-broken-out.tar.gz
box:/home/akpm/aa/linux-2.6.18-rc6> mv broken-out patches
box:/home/akpm/aa/linux-2.6.18-rc6> quilt push -a > /dev/null
box:/home/akpm/aa/linux-2.6.18-rc6> quilt applied | wc -l
1835

box:/home/akpm/aa/linux-2.6.18-rc6> quilt --version
0.45
