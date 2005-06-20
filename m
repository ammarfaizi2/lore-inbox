Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVFTVfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVFTVfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFTVTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:19:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:7372 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261617AbVFTVSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:18:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dipankar@in.ibm.com
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Date: Mon, 20 Jun 2005 23:18:37 +0200
User-Agent: KMail/1.8.1
Cc: jan malstrom <xanon@snacksy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <42B6BEC2.405@snacksy.com> <20050620202145.GC4622@in.ibm.com>
In-Reply-To: <20050620202145.GC4622@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202318.37930.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 20 of June 2005 22:21, Dipankar Sarma wrote:
> On Mon, Jun 20, 2005 at 03:04:02PM +0200, jan malstrom wrote:
> > right at booting:
> > 
> > 
> > Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
> > Jun 20 14:38:07 hades kernel: invalid operand: 0000 [#1]
> > Jun 20 14:38:07 hades kernel: PREEMPT
> > Jun 20 14:38:07 hades kernel: Modules linked in: ipw2100 i2c_i801
> > Jun 20 14:38:07 hades kernel: CPU:    0
> > Jun 20 14:38:07 hades kernel: EIP:    0060:[fd_install+309/400]    Not 
> > tainted VLI
> 
> Can you try the following patch and let me know if it fixes any
> of your problems ?

No, it doesn't.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
