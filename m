Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbUJ0R43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbUJ0R43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUJ0Rww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:52:52 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:29095 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262587AbUJ0Rse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:48:34 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-os@analogic.com
Subject: Re: solution Re: lost memory on a 4GB amd64
Date: Wed, 27 Oct 2004 18:47:41 +0100
User-Agent: KMail/1.7
Cc: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>,
       Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
       Andi Kleen <ak@muc.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <Pine.LNX.4.58.0410271751330.3903@pluto.physik.uni-wuerzburg.de> <Pine.LNX.4.61.0410271238180.6872@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410271238180.6872@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271847.41827.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 Oct 2004 17:44, linux-os wrote:
>
> Could you please explain how memory is connected to only one
> CPU? I don't think this is possible.

The DIMMS are connected connected to cpu1. cpu2 accesses the ram with the 
Hypertransport bus.

See page 9 of ftp://ftp.tyan.com/manuals/m_s2875_102.pdf


>
> Is this board for some new multiple-CPU specification? It can't
> work for SMP (symmetrical multiprocessor specification) unless
> both CPUs can access the same RAM.

They can. Its a sort of castrated NUMA board :)

Andrew Walrond
