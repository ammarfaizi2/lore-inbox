Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVE2AGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVE2AGT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 20:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVE2AGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 20:06:19 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6048 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261199AbVE2AGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 20:06:14 -0400
Subject: Re: How to find if BIOS has already enabled the device
From: Lee Revell <rlrevell@joe-job.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200505281301.09911.kernel-stuff@comcast.net>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com>
	 <200505281018.18092.kernel-stuff@comcast.net>
	 <1117296905.2356.23.camel@localhost.localdomain>
	 <200505281301.09911.kernel-stuff@comcast.net>
Content-Type: text/plain
Date: Sat, 28 May 2005 20:06:11 -0400
Message-Id: <1117325172.5423.102.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-28 at 13:01 -0400, Parag Warudkar wrote:
> devfs_mk_dev: could not append to parent for vcc/5
> devfs_mk_dev: could not append to parent for vcc/a5
> devfs_mk_dev: could not append to parent for vcc/6
> devfs_mk_dev: could not append to parent for vcc/a6

devfs is not maintained and is listed as deprecated.  You'd be better
off using udev.

Lee

