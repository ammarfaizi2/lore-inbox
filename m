Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSGDOan>; Thu, 4 Jul 2002 10:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSGDOam>; Thu, 4 Jul 2002 10:30:42 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:12046 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317421AbSGDOam>; Thu, 4 Jul 2002 10:30:42 -0400
Date: Thu, 4 Jul 2002 15:33:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 IDE 97
Message-ID: <20020704153313.F11601@flint.arm.linux.org.uk>
References: <Pine.SOL.4.30.0207030021060.27685-200000@mion.elka.pw.edu.pl> <20020704142938.D11601@flint.arm.linux.org.uk> <20020704161809.A27207@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020704161809.A27207@ucw.cz>; from vojtech@suse.cz on Thu, Jul 04, 2002 at 04:18:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 04:18:09PM +0200, Vojtech Pavlik wrote:
> I think the best solution (for now) probably would be to supply the mode
> map to the core IDE driver so that it can choose which modes (and
> whether DMA) are available.

I'm not really following your proposal, so I'll only say that as long as
the chipset driver can tell the core what its capabilities are _after_
running some chipset specific code, I'll be happy.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

