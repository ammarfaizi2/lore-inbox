Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTLPXd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTLPXd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:33:58 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:45512 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264321AbTLPXd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:33:57 -0500
Subject: Re: essid any -> orinoco_lock() called with hw_unavailable -test11
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1071571879.2498.65.camel@localhost>
References: <1071571879.2498.65.camel@localhost>
Content-Type: text/plain
Message-Id: <1071617600.734.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 10:33:21 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-16 at 21:51, Soeren Sonnenburg wrote:
> Hi.
> 
> I get quiete many error messages in when I do
> 
> ifconfig eth1 192.168.0.1 up
> iwconfig eth1 mode ad-hoc
> iwconfig eth1 nick bla
> iwconfig eth1 key off
> iwconfig eth1 essid "any"
> ifconfig eth1 down
> 
> and no wireless network is available. The device is no longer accessible
> afterwards. Reloading kernel modules helps, however if I go to sleep
> mode on this 1GHz 15" G4 Powerbook the machine hangs on resume, see
> 
> http://www.nn7.de/kernel/essid_any.jpg
> 
> for the messages and xmon trace (please use a webbrowser to view it, it
> is a redirect)

Which test11 ? Did you try my tree ?

(ppc.bkbits.net/linuxppc-2.5-benh via bitkeeper, rsync mirror on
source.mvista.com)

Ben.


