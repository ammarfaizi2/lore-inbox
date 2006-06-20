Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWFTW2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWFTW2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWFTW2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:28:04 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:22507 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751315AbWFTW2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:02 -0400
Message-ID: <44987661.5050907@myri.com>
Date: Tue, 20 Jun 2006 18:27:45 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andi Kleen <ak@suse.de>, Dave Olson <olson@unixfolk.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de> <20060620212908.GA17012@suse.de>
In-Reply-To: <20060620212908.GA17012@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> No, I don't want a whitelist, as it will be hard to always keep adding
> stuff to it (unless we can somehow figure out how to put a "cut-off"
> date check in there).

My second patchset (Improve MSI detection v2) uses "PCI-E vs non-PCI-E"
as a cut-off "date". After reading all what people said in this thread,
I still think it is a good compromise (and very simple to implement) if
we blacklist PCI-E and whitelist non-PCI-E chipsets.

Brice

