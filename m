Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTIZPSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTIZPSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:18:32 -0400
Received: from citi.umich.edu ([141.211.92.141]:62264 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S262349AbTIZPS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:18:29 -0400
Date: Fri, 26 Sep 2003 11:18:27 -0400
From: Joe McClain <jmcclai@umich.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
Message-ID: <20030926151827.GA25361@umich.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Maciej Zenczykowski <maze@cela.pl> [030926 10:06]:
> Hi,
> 
> I'm wondering if there is any way to provide per process bitmasks of 
> available/illegal syscalls.  Obviously this should most likely be 
> inherited through exec/fork.
> 
> For example specyfying that pid N should return -ENOSYS on all syscalls 
> except read/write/exit.

Look at Systrace.  http://www.citi.umich.edu/u/provos/systrace/


- Joe
