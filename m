Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbULQNQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbULQNQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbULQNQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:16:45 -0500
Received: from neopsis.com ([213.239.204.14]:18158 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S262801AbULQNQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:16:44 -0500
Message-ID: <41C2DCBC.1080302@dbservice.com>
Date: Fri, 17 Dec 2004 14:18:52 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
Cc: Patrick McHardy <kaber@trash.net>, Bryan Fulton <bryan@coverity.com>,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
References: <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> That's what I meant, you need the capability to do anything bad :-)
> 

But.. even if you have the 'permission' to do bad things, it shouldn't 
be possible.

It's a bug, and only because you can't exploit it if you haven't the 
right capabilities doesn't make the bug disappear.

IMHO such things (passing values between user/kernel space) should 
always be checked.

tom
