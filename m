Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTIRPrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 11:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTIRPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 11:47:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:43425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261321AbTIRPrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 11:47:01 -0400
Date: Thu, 18 Sep 2003 08:40:11 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jesper Juhl <jju@dif.dk>
Cc: cherry@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: IA32 - 27 New warnings
Message-Id: <20030918084011.5ac7be61.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0309181518090.10528@jju_lnx.backbone.dif.dk>
References: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
	<Pine.LNX.4.56.0309181518090.10528@jju_lnx.backbone.dif.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003 15:33:21 +0200 (CEST) Jesper Juhl <jju@dif.dk> wrote:

| 
| On Wed, 17 Sep 2003, John Cherry wrote:
| 
| > drivers/ide/legacy/pdc4030.c:307: warning: `return' with no value, in function returning non-void
| > drivers/ide/legacy/pdc4030.c:323: warning: control reaches end of non-void function
| 
| Below is a patch that silences those two warnings and (hopefully) does the
| right thing (I'll attempt to deal with the other ones later today).
| 
| I've tried as best I could to work out the logic of what goes on in that
| file, and I /think/ I got it right, but I don't have the hardware to test
| if I broke something horribly, so someone more knowledgable than me is
| needed to confirm the patch and preferably some brave soul with Promise
| hardware to test it as well.
| 
| A little explanation of why I do what I do in the patch:

[snip]

Bart (IDE maintainer) has already posted patches for this.
See
http://marc.theaimsgroup.com/?l=linux-kernel&m=106329427503487&w=2

--
~Randy
