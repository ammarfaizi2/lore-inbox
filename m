Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUE0TQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUE0TQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265073AbUE0TOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:14:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30162 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265067AbUE0TOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:14:41 -0400
Date: Thu, 27 May 2004 20:57:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "A. op de Weegh" <aopdeweegh@rockopnh.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Granting some root permissions to certain users
Message-ID: <20040527185713.GB509@openzaurus.ucw.cz>
References: <jbm.20040525185001.f766d1ea@TOSHIBA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jbm.20040525185001.f766d1ea@TOSHIBA>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> At our school, we have a installed Fedora Core 1 on a machine which acts as a 
> server. Our students may store reports and other products, that they have 
> created for their lessons, on this machine. Also the teachers have an 
> account.
>  
> I would like the teachers to have list access on ALL directories. Just as the 
> root user has. I wouldn't like the teachers to have all root permissions, but 
> they should only be able to list ALL directories available. Viewing only, no 
> writing.
>  
> Any idea how I can achieve this?

Create setuid ls with permissions rwxr-x--- root.teachers.

Teachers may be able to get root if they are real good hackers (and exploit
some bug in ls), but
they certainly not break anything by mistake.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

