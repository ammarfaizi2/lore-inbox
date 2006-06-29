Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWF2Q7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWF2Q7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWF2Q7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:59:21 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:10898 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750973AbWF2Q7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:59:20 -0400
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
In-Reply-To: <1151536204.3377.51.camel@mulgrave.il.steeleye.com>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	 <20060626200433.bf0292af.akpm@osdl.org>
	 <1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	 <20060626220337.06014184.akpm@osdl.org>
	 <1151419746.3340.13.camel@mulgrave.il.steeleye.com>
	 <20060627170446.30392b00.akpm@osdl.org>
	 <1151462735.5793.2.camel@mulgrave.il.steeleye.com>
	 <20060627195743.ce18afe3.akpm@osdl.org>
	 <1151536204.3377.51.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 12:58:55 -0400
Message-Id: <1151600336.6186.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 19:10 -0400, James Bottomley wrote:
> I'm still compiling, so might have the results later this evening.

Actually, ran into a 53c700 driver problem, but I can now verify that
this patch works on voyager when booting with a non-zero CPU.

James


