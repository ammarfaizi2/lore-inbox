Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVJaLsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVJaLsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVJaLsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:48:25 -0500
Received: from main.gmane.org ([80.91.229.2]:6340 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751124AbVJaLsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:48:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Mon, 31 Oct 2005 12:45:05 +0100
Message-ID: <xuqtrovd2yxc$.u541lhorc80y.dlg@40tude.net>
References: <20051029182228.GA14495@havoc.gtf.org> <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0510310109250.16065@qynat.qvtvafvgr.pbz> <200510310334.35597.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-138-251.37-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005 03:34:34 -0600, Rob Landley wrote:

> On Monday 31 October 2005 03:13, David Lang wrote:
>>> I was thinking about doing thatn in hidden input fields and
>>> passing form back and forth.  After all what real git bisect
>>> keeps locally are one bad commit ID and bunch of good commit
>>> IDs.
>>
>> if it's kept in a file or cookie then it can survive a reboot and other
>> distractions (remember that this process can take days if the problem
>> doesn't show up at boot). a cookie can hold a couple K worth of data, a
>> file has no size limit.
> 
> Actually, lots of Linux browsers these days treats all cookies as session 
> cookies for security reasons.  So surviving a reboot still isn't guaranteed.  
> But it's possible.
> 
> You can also have 'em bookmark a URL...

Trac has a 'Session ID' key that stores something like a cookie,
except that it's serverside. Something halfway a cookie and an actual
login. The user can write down the session ID or just assign its own,
and the re-enter the session ID and all things are restored to the
settings he had chosen. Something like this, maybe?

-- 
Giuseppe "Oblomov" Bilotta

"I'm never quite so stupid
 as when I'm being smart" --Linus van Pelt

