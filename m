Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVBKSrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVBKSrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVBKSrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:47:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262282AbVBKSqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:46:05 -0500
Date: Fri, 11 Feb 2005 13:46:04 -0500
From: Dave Jones <davej@redhat.com>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
Message-ID: <20050211184604.GB15721@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
References: <420C4B9A.6020900@web.de> <20050211062100.GB1782@redhat.com> <420CDB93.70506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420CDB93.70506@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 05:21:39PM +0100, Marcus Hartig wrote:

 > No warnings/errors in both logs. All clean. But switching/maximizing 
 > between tasks like firefox, thunderbird or a gnome-terminal is so slow, 
 > that you can see it how firefox/GTK+ theme is writing the GUI and the 
 > fonts slowly back. Minimizing is no more fun, like a fast slide-show. And 
 > that on a fast amd64 3200 with 1 GB RAM and a FX 5900XT. :(

None of this involves 3D operation, or AGPGART.

 > With the nVidia own nv_agp it appears directly in all apps, very fast 
 > under GNOME 2.8.1. Why, I do not know. Also game (opengl) performance is 
 > faster with the nv_agp, that I haven't used the kernel agp for months, now.

*shrug*, if the nvidia module is properly configured, it should make
no difference at all. AGPGART operation isn't a performance critical
thing, as the hardware does 99% of the work.

 
		Dave

