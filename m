Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUIPXOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUIPXOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUIPXON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:14:13 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:40712 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S268339AbUIPXMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:12:54 -0400
Subject: Re: [PATCH] gen_init_cpio uses external file list
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, klibc@zytor.com
In-Reply-To: <414A1C92.3070205@pobox.com>
References: <1095372672.19900.72.camel@tubarao> <414A1C92.3070205@pobox.com>
Content-Type: text/plain
Organization: Linux Networx
Date: Thu, 16 Sep 2004 16:53:55 -0600
Message-Id: <1095375235.19900.82.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 19:06 -0400, Jeff Garzik wrote:
> Seems OK to me...
> 
> 	Jeff, the original gen_init_cpio author

There's been some minor discussion about the use of _GNU_SOURCE (needed
for getline()).  Comments?  I can rework the getline() if anyone can
make a case - otherwise I'm a bit lazy.


