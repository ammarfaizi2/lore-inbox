Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUDSVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUDSVBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUDSVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:01:37 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:55559 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S261843AbUDSVBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:01:33 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.4.26 IRDA BUG - blocker
Date: Mon, 19 Apr 2004 23:01:26 +0200
User-Agent: KMail/1.6
References: <200404190152.16594.cijoml@volny.cz> <20040419133507.GB10382@gateway.milesteg.arr>
In-Reply-To: <20040419133507.GB10382@gateway.milesteg.arr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404192301.26933.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yes, this driver was backported to 2.4 from 2.6.
But it is not problem in this driver, bus somewhere deeper in Irda stack, coz 
I used it about 6 mounths without problem with previous version of irda 
stack.

Michal

Dne po 19. dubna 2004 15:35 Daniele Venzano napsal(a):
> On Mon, Apr 19, 2004 at 01:52:16AM +0200, Michal Semler (volny.cz) wrote:
> > When I try connect with 2.4.26 kernel to T68i
> > I getts this message and then port freezes - no devices discovered and no
> > communication, sometimes freezes whole laptop:
>
> I'm seeing this same behaviour with a Nokia 6610, same modules, same
> messages, but kernel 2.6.5.
> I also noted that with irdaping I loose one ping every 2, so that
> sequence numbers follow the following pattern:
> 1
> 2
> 4
> 5
> 7
> 8
> ...
