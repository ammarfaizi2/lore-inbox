Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWCBRqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWCBRqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWCBRqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:46:34 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:44895 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932257AbWCBRqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:46:33 -0500
Subject: Re: using usblp with ppdev?
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, wixor <wixorpeek@gmail.com>
In-Reply-To: <20060302165557.GA31247@kroah.com>
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com>
	 <20060302165557.GA31247@kroah.com>
Content-Type: text/plain
Organization: private
Date: Thu, 02 Mar 2006 18:46:16 +0100
Message-Id: <1141321576.31089.14.camel@playstation2.hb9jnx.ampr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 32700;
	Body=3 Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 08:55 -0800, Greg KH wrote:

> Anyway, no, the usblp driver is not what you want, you probably want the
> uss720 driver, which does register with parport.

That's actually the reason for the existence of the uss720 driver. I'm
using it occasionally to program PIC microcontrollers.

This method is quite slow compared to a southbridge parport. But there
have been huge improvements to the speed and reliability in the last
couple of years. Kudos to Greg KH, Alan Stern, David Brownell et al.!

Tom


