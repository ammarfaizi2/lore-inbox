Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272731AbTHPKyG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 06:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272739AbTHPKyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 06:54:06 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:6394 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S272731AbTHPKyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 06:54:04 -0400
Subject: Re: increased verbosity in dmesg
From: Martin Schlemmer <azarah@gentoo.org>
To: gene.heskett@verizon.net
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308160438.59489.gene.heskett@verizon.net>
References: <200308160438.59489.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1061030883.13257.253.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 12:48:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-16 at 10:38, Gene Heskett wrote:
> Greetings;
> 
> The recently increased verbosity in the dmesg file is causeing the 
> "ring buffer" to overflow, and I am not now seeing the first few 
> pages of the reboot in the dmesg file.
> 

> Is there any quick and dirty way to increase this to at least 32k, or 
> maybe even to 64k?  With half a gig of memory, this shouldn't be a 
> problem should it?
> 

 # dmesg -s 30000

Works here.


-- 
Martin Schlemmer


