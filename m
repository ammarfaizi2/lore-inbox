Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVCGLTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVCGLTv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVCGLTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:19:51 -0500
Received: from isilmar.linta.de ([213.239.214.66]:51647 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261281AbVCGLTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:19:50 -0500
Date: Mon, 7 Mar 2005 05:19:13 -0600
From: Hendrik Hoeth <hendrik.hoeth@cern.ch>
To: linux-kernel@vger.kernel.org, linux@brodo.de
Subject: Re: serial CardBus card does not wake up after sleep
Message-ID: <20050307111913.GA3422@mail.physik.uni-wuppertal.de>
References: <20050306200946.GD3101@mail.physik.uni-wuppertal.de> <20050306224112.C3834@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306224112.C3834@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-URL: http://www.philippi-trust.de/hendrik/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Russell King (rmk+lkml@arm.linux.org.uk):

> Looks like the card wasn't resumed properly.  Please try this patch:

Thanks! The patch works fine for me: The card wakes up, only the current
connection to the ISP is lost (not a surprise).

-- 
Die gesellschaftliche Konversation waere ein ausgezeichnetes
Schlafmittel, wenn die Leute sich angewoehnen koennten, etwas
leiser zu sprechen.
                         -- George Bernard Shaw
