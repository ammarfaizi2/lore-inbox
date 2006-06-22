Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWFVLWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWFVLWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWFVLWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:22:49 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:46727 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1161064AbWFVLWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:22:49 -0400
Date: Thu, 22 Jun 2006 12:22:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: ankur maheshwari <ankur_maheshwari@procsys.com>
Cc: Jean Delvare <khali@linux-fr.org>, Pete Popov <ppopov@embeddedalley.com>,
       linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
Message-ID: <20060622112246.GB4032@linux-mips.org>
References: <20060620120836.628ddc79.khali@linux-fr.org> <110701c694f4$f1412fb0$f301a8c0@procsys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110701c694f4$f1412fb0$f301a8c0@procsys>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 11:08:34AM +0530, ankur maheshwari wrote:

> I have used once i2c-adap-ite and i2c-algo-ite for ite-8712 chip and it
> worked fine for me in MV 2.4.25.

The fact that is used to work in some vendor kernel is irrelevant.  And
2.4 hardly indicates anyway.

> Its been an year ago, I asked on same forum if some one has used it
> before but I didn't got any reply.

You see how amazingly popular the board was.  On April 2 just after
2.6.16 was out I announced my intension to remove the board in

  http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060402194822.GA26358%40linux-mips.org

Nobody raised hand to take care of the maintenance of any of these boards,
thus http://www.linux-mips.org/wiki/ITE-8172G also marks the board as
to be deleted.

> It's just an info on ite-chip works, to remove it from kernel tree .....
> decision is up to you : ).

There is more that just that wrong with the board support.  And if the
fact that it is was broken does not even result bug reports this is
another indicator the board a board should go.

The usual reminder: patches to fix the issues will be accepted.

  Ralf
