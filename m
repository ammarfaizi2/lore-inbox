Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTJBRcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTJBRcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:32:43 -0400
Received: from h1ab.lcom.net ([216.51.237.171]:38784 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S263430AbTJBRbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:31:37 -0400
Date: Thu, 2 Oct 2003 12:31:31 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Problems with PCMCIA and CardBus in 2.6.0-test6
Message-ID: <20031002173130.GA3536@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm having problems with 2.6.0-test6-mm1 (actually, since 2.6.0-testx, iirc)
Essentially, pcmcia does not work at all.  IIRC, ds loads, but nothing
  else, and starting pcmcia manager does not work at all.  Furthermore, if
  I try to manually insert the yenta socket, my aironet card locks up
  (the Activity light lights up solid) and not even Magic SysRq keys work.
  The yenta socket is what I've been using for quite a while in the 2.4
  series.  
Some important details:
  chip is 00:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
          Subsystem: Toshiba America Info Systems: Unknown device 0001
  yenta_socket is built as a module.
Anyone know of more testing I could do to figure out the problem?  I'm
  rebuilding 2.6 with yenta_socket builtin, instead of as a module.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
