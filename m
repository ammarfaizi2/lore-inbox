Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266007AbUFDUr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUFDUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUFDUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:47:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9871 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266006AbUFDUrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:47:25 -0400
Message-ID: <40C0DFD1.7080107@pobox.com>
Date: Fri, 04 Jun 2004 16:47:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: dctucker@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: network driver causes kernel panic
References: <200405310955.i4V9tI7Z025408@harpo.it.uu.se>
In-Reply-To: <200405310955.i4V9tI7Z025408@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This confirms that eth1 is a 21041 driven by the de2104x driver.
> 
> I've seen something very similar to Casey's problem, on a PowerMac
> with a built-in 21041. Booting it with no network cable connected
> causes a timer to hit a BUG() in de2104x about a second after
> the device is ifup:d.
> 
> The 2.4 kernel's tulip driver works just fine.
> 
> I reported this last year, but nothing happened.


Well, I'm very interested in debugging it.  There were a flurry of 
de2104x patches in the past year, I thought that took care of the issues.

Please email details to netdev@oss.sgi.com and jgarzik@pobox.com...

	Jeff


