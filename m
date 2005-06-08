Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVFHKfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVFHKfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVFHKfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:35:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44710 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262161AbVFHKfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:35:16 -0400
Date: Wed, 8 Jun 2005 12:34:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: race in usbnet.c in full RT
Message-ID: <20050608103440.GA18380@elte.hu>
References: <42A6C6B3.2000303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A6C6B3.2000303@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eugeny S. Mints <emints@ru.mvista.com> wrote:

> seems there is a race in drivers/net/usbnet.c in full RT mode. To be 
> honest I haven't hardly checked this on the latest kernel and latest 
> RT patch but just took a look at usbnet.c and latest RT patch and 
> haven't observed any related changes.

thanks, i've applied your patch to my tree. Note that your patch is 
specific to the -RT kernel (both in terms of semantics and in term of 
API dependence), so it does not make any sense to apply it upstream.  
David, please ignore it.

	Ingo
