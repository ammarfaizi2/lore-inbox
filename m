Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTEWLAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 07:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbTEWLAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 07:00:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43023 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264016AbTEWLAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 07:00:42 -0400
Date: Fri, 23 May 2003 12:13:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Lothar Wassmann <LW@KARO-electronics.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030523121345.A32110@flint.arm.linux.org.uk>
Mail-Followup-To: Lothar Wassmann <LW@KARO-electronics.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <16076.50160.67366.435042@ipc1.karo> <20030522151156.C12171@flint.arm.linux.org.uk> <16077.55787.797668.329213@ipc1.karo> <20030523022454.61a180dd.akpm@digeo.com> <16077.61981.684846.221686@ipc1.karo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16077.61981.684846.221686@ipc1.karo>; from LW@KARO-electronics.de on Fri, May 23, 2003 at 12:04:13PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 12:04:13PM +0200, Lothar Wassmann wrote:
> Is 2.5.68 current enough? The problem was even better reproducible
> with this kernel than with the old one. So I made all my tests with
> 2.5.68.

Can you attach the test program which reproduces your problem, and
include a description of what you think is going wrong?

AFAICS, you have only pointed out that a call to flush_page_to_ram()
without further information.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

