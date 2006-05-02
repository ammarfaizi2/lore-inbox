Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWEBQDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWEBQDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWEBQDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:03:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:151 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964906AbWEBQDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:03:13 -0400
From: Andi Kleen <ak@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Van Jacobson's net channels and real-time
Date: Tue, 2 May 2006 17:58:52 +0200
User-Agent: KMail/1.9.1
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Auke Kok <sofar@foo-projects.org>, Auke Kok <auke-jan.h.kok@intel.com>,
       Ingo Oeser <ioe-lkml@rameria.de>,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <Pine.LNX.4.61.0604250717590.28279@chaos.analogic.com> <20060502124131.GA13160@suse.cz>
In-Reply-To: <20060502124131.GA13160@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021758.52889.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 14:41, Vojtech Pavlik wrote:
 
> You seem to be missing the fact that most of todays interrupts are
> delivered through the APIC bus, which isn't fast at all.

You mean slow right?  Modern x86s (anything newer than a P3) generally don't 
have an separate APIC bus anymore but just send messages over their main
processor connection.

-Andi
