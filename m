Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264620AbTIIUyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbTIIUyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:54:41 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:40839 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264620AbTIIUyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:54:40 -0400
Subject: Re: wierd raid 1 problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ying-Hung Chen <ying@yingternet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F5E14FC.5090001@yingternet.com>
References: <3F5E14FC.5090001@yingternet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063140808.30962.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 21:53:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 18:59, Ying-Hung Chen wrote:
> the corrupted files seem to 'recover' itself if i leave the machine 
> alone for a while or umount and mount back the filesystem.
> 
> does anyone have this type of temperory file corruption problem? I 
> tested it against 2.4.2x kernel including the last vanilla 2.4.22 + xfs 
> patches, they all seem to have the same problem

Classic symptoms of bad memory or a kernel bug corrupting data. See if
the box passes memtest86 as a starter

