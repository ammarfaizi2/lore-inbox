Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUFXLgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUFXLgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUFXLgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:36:11 -0400
Received: from colin2.muc.de ([193.149.48.15]:5133 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264270AbUFXLgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:36:09 -0400
Date: 24 Jun 2004 13:36:08 +0200
Date: Thu, 24 Jun 2004 13:36:08 +0200
From: Andi Kleen <ak@muc.de>
To: Yusuf Goolamabbas <yusufg@outblaze.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
Message-ID: <20040624113608.GA31080@colin2.muc.de>
References: <2ayz2-1Um-15@gated-at.bofh.it> <m3n02tz203.fsf@averell.firstfloor.org> <20040624104416.GB8798@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624104416.GB8798@outblaze.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, Is there a way to determine which syscall would be the culprit. I
> guess this is where something like DTrace would be invaluable

Find out which program does it (most likely those with the most
system time) and then strace it.
> 
> http://www.sun.com/bigadmin/content/dtrace/

Sounds like a inferior clone of dprobes to me. But I doubt it 
would help tracking this down.

-Andi
