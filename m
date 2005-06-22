Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVFVJV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVFVJV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVFVHpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:45:14 -0400
Received: from main.gmane.org ([80.91.229.2]:43138 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262845AbVFVF5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:57:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Atkins <martin_ml@mca-ltd.com>
Subject: Re: v9fs (-mm -> 2.6.13 merge status)
Date: Wed, 22 Jun 2005 05:13:28 +0000 (UTC)
Message-ID: <loom.20050622T070010-433@post.gmane.org>
References: <20050620235458.5b437274.akpm@osdl.org> <a4e6962a05062106515757849d@mail.gmail.com> <20050621153552.GJ22656@server4.lensbuddy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 220.226.22.160 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041209 Firefox/1.0 (Ubuntu) (Ubuntu package 1.0-2ubuntu4-warty99))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uriel <uriell <at> binarydream.org> writes:
>..
> The 9P protocol implemented by v9fs is the result of over a decade of 
> research in distributed systems at Bell Labs by the original Unix team,

I would second that. There are several other filesystems already merged or
under discussion that are superficially similar - fuse, coda, and even nfs!
However, v9fs is the only one that is (all of)
1) suitable for synthetic filesystems (resources),
   as well as 'normal' filesystems
2) equally good for local and remote filesystems
3) OS/machine independent "on-the-wire"
4) (network) transport independent
5) has a significant history of deployment

If there are few Linux applications using v9fs as yet (but there is plan9ports),
then one must admit that there is something of a chicken-and-eggs
situation involved!

Martin


