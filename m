Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUHPNdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUHPNdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267630AbUHPNdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:33:17 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:15499 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S267624AbUHPNcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:32:54 -0400
Date: Mon, 16 Aug 2004 16:32:51 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-ID: <20040816133250.GA17379@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <411FD919.9030702@comcast.net> <20040816143817.0de30197.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816143817.0de30197.Ballarin.Marc@gmx.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:38:17PM +0200, Marc Ballarin wrote:
> On Sun, 15 Aug 2004 14:43:53 -0700
> John Wendel <jwendel10@comcast.net> wrote:
> 
> > K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1.
> 
> Due to the newly added command filtering, you now need to run cdrecord as
> root. Since cdrecord will drop root privileges before accessing the drive,
> setuid root won't help.


I can't confirm this.

I also have LITE-ON LTR-52327S and suid-root cdrecord burns just fine with
kernel 2.6.8.1. It's cdrecord 2.00.3 from Slackware. (I don't use any
graphic front end). cdrecord -checkdrive tells among other things this:
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
