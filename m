Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTI3Jwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTI3Jwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:52:31 -0400
Received: from users.linvision.com ([62.58.92.114]:33423 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261309AbTI3Jwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:52:30 -0400
Date: Tue, 30 Sep 2003 11:52:29 +0200
From: Rogier Wolff <Swen-Trap1@BitWizard.nl>
To: Artur Klauser <Artur.Klauser@computer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: div64.h:do_div() bug
Message-ID: <20030930095229.GA32421@bitwizard.nl>
References: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 03:25:19PM +0200, Artur Klauser wrote:
> I've found that a bug in asm-arm/div64.h:do_div() is preventing correct
> conversion of timestamps in smbfs (and probably ntfs as well) from NT to

Nope. 

>   if (in.n64 != out.n64) {
>     printf("FAILURE: asm/div64.h:do_div() is broken for 64-bit dividends\n");

do_div should be/is documented as not doing 64 bit dividents. It does
64/32 -> 32 divides, IIRC... 

		Roger. 

(This EMail has a Unique reply address, so that I can count the number
of times that SWEN bites... :-)

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
