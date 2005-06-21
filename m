Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVFVADp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVFVADp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVFVAAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:00:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:4010 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262462AbVFUXwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:52:23 -0400
Message-ID: <42B8A82E.4020207@pobox.com>
Date: Tue, 21 Jun 2005 19:52:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
References: <Pine.LNX.4.58.0506211304320.2915@skynet> <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com> <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com> <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com> <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org> <42B859B4.5060209@pobox.com> <Pine.LNX.4.58.0506211124310.2268@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211124310.2268@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
>>If git-checkout-script switches the .git/HEAD symlink properly, rather 
>>than updating the symlink target's contents, then my git-switch-tree 
>>script can just go away :)
> 
> 
> Well, you should test it. I sure didn't ;)

hmmm, I tried

	git checkout -f ncq

on libata-dev.git and it didn't seem to switch the symlink.

	Jeff



