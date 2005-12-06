Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVLFCYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVLFCYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVLFCYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:24:36 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:16534 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964933AbVLFCYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:24:34 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andy Isaacson <adi@hexapodia.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051206020626.GO22168@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <200512052328.01999.rjw@sisk.pl> <1133832773.6360.38.camel@localhost>
	 <20051206020626.GO22168@hexapodia.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133835651.3896.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 12:21:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-12-06 at 12:06, Andy Isaacson wrote:
> On Tue, Dec 06, 2005 at 11:36:13AM +1000, Nigel Cunningham wrote:
> I'm assuming that the difference is that with Rafael's patches, clean
> pages that would have been evicted in the "freeing pages..." step are
> now being written out to the swsusp image.  If so, this is a waste - no
> point in having the data on disk twice.  (It would be nice to confirm
> this suspicion.)

Forgot to mention - that's true.

Regards,

Nigel

