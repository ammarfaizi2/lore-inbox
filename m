Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTDSAIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 20:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTDSAIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 20:08:17 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:20526 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S263315AbTDSAIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 20:08:16 -0400
Subject: Re: 2.5.67-mm4: select-speedup.patch breaks Evolution
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030418123327.0d048282.akpm@digeo.com>
References: <1050687280.595.3.camel@teapot.felipe-alfaro.com>
	 <20030418123327.0d048282.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1050711279.1655.1.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
Date: 18 Apr 2003 20:16:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-18 at 15:33, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > 2.5.67-mm4 breaks Evolution 1.2.3: when clicking on "Sending/Receiving"
> > toolbar button, Evolution displays the progress dialog box but it hangs
> > forever, that is, no mail is sent or received. All my accounts are POP3.
> > 
> > Reverting "select-speedup.patch" fixes the problem.
> 
> Ah.  Thanks for the detective work.  I'll take a closer look.

As another data point, this seems to be the cause of my Mozilla hanging
when I go to a page that uses flash.  Works fine without the patch.

Later,
Tom


