Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbTJGUTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTJGUTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:19:30 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:48518 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262748AbTJGUT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:19:29 -0400
Date: Tue, 7 Oct 2003 22:19:14 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: Juliusz Chroboczek <jch@pps.jussieu.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MCE: The hardware reports... (AMD Duron)
Message-ID: <20031007201914.GA25368@neon>
Mail-Followup-To: Juliusz Chroboczek <jch@pps.jussieu.fr>,
	linux-kernel@vger.kernel.org
References: <tppth8j07y.fsf@helium.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tppth8j07y.fsf@helium.pps.jussieu.fr>
Organization: pearbough.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juliusz!

On Tue, 07 Oct 2003, Juliusz Chroboczek wrote:

> Under both 2.6.0test4 and test6, I'm fairly regularly getting the
> following at boot time:
> 
>  MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
>  Bank 0: e603800000000175
> 
> The machine is a Compaq Presario 711, with a 950MHz Mobile Duron
> (family 6 model 7 stepping 1 according to /proc/cpuinfo).
> 
> The Intel docs seem to imply that this is something memory-related, I
> couldn't find the relevant AMD docs.
> 
> Would somebody be so kind as to explain what the above means?

In the sources it says: 
/* AMD K7 machine check is Intel like */

So I guess the information you find about Intel Machine Check Exceptions
concerning your MCE also applies to AMDs.

Greetings,
Axel


____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net |

I either want less decadence or more chance to participate in it.
____________________________________________________________________________
