Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWGLPWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWGLPWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWGLPWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:22:17 -0400
Received: from xenotime.net ([66.160.160.81]:28636 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751409AbWGLPWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:22:16 -0400
Date: Wed, 12 Jul 2006 08:25:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt Reuther <mreuther@umich.edu>
Cc: adaplas@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
Message-Id: <20060712082502.7d311342.rdunlap@xenotime.net>
In-Reply-To: <200607120841.49753.mreuther@umich.edu>
References: <200607100833.00461.mreuther@umich.edu>
	<200607110720.54119.mreuther@umich.edu>
	<44B3A3A5.5030208@gmail.com>
	<200607120841.49753.mreuther@umich.edu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 08:41:48 -0400 Matt Reuther wrote:

> The depmod problems are gone, except for the reiser4 warning about 
> generic_file_read. I thought I had the right patch for that, too, but I guess 
> not.

This one seems to be the correct one:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115253892505274&w=2

---
~Randy
