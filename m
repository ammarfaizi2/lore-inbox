Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbULPG1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbULPG1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 01:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbULPG1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 01:27:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42762 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262582AbULPG1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 01:27:49 -0500
Date: Thu, 16 Dec 2004 07:10:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Adam Denenberg <adam@dberg.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: bind() udp behavior 2.6.8.1
Message-ID: <20041216061029.GI17946@alpha.home.local>
References: <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com> <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org> <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com> <1103120162.5517.14.camel@sucka> <20041215190725.GA24635@delft.aura.cs.cmu.edu> <1103138573.6825.11.camel@sucka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103138573.6825.11.camel@sucka>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 02:22:53PM -0500, Adam Denenberg wrote:
> So my question is, why is the kernel not incrementing the DNS ID in this case?

Uhh ?
The *kernel* should change IDs in the *DNS* request ? It is the libc which does
the DNS requests. The only ID the kernel could play with it the IP packet ID.

Willy

