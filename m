Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbUKCX7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUKCX7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKCX4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:56:23 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:5055 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261999AbUKCXxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:53:01 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Mathieu Segaud <matt@minas-morgul.org>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 18:56:30 -0500
User-Agent: KMail/1.7
Cc: Doug McNaught <doug@mcnaught.org>, Jim Nelson <james4765@verizon.net>,
       DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031733.30469.rmiller@duskglow.com> <877jp2sdfd.fsf@barad-dur.crans.org>
In-Reply-To: <877jp2sdfd.fsf@barad-dur.crans.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031756.30112.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 17:47, Mathieu Segaud wrote:

> this is because nfs related syscalls are not interruptible by default.
> you can make them interruptible by mounting your nfs's with the 'intr'
> option.

That doesn't appear to work, then.  Because we do mount them with the intr 
option, and the behavior doesn't seem to be any different.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
