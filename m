Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTERV0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTERV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 17:26:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33458
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262211AbTERV0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 17:26:46 -0400
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@muc.de>, Dave Jones <davej@codemonkey.org.uk>,
       kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030518161105.GA7404@mail.jlokier.co.uk>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de>
	 <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk>
	 <20030518053935.GA4112@averell>  <20030518161105.GA7404@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053290431.27107.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 May 2003 21:40:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-18 at 17:11, Jamie Lokier wrote:
> > Can you provide PCI info for them to add a quirk ? 
> 
> What exactly "doesn't work" with these cards?

If you sent an MTRR you get crap on the display. I'm not sure if that is
registers being covered (seems dubious) or other PCI problems perhaps
with bursts

