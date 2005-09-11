Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbVIKAHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbVIKAHe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbVIKAHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:07:34 -0400
Received: from mail.collax.com ([213.164.67.137]:20396 "EHLO
	kaber.coreworks.de") by vger.kernel.org with ESMTP id S932714AbVIKAHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:07:33 -0400
Message-ID: <4323753D.9030007@trash.net>
Date: Sun, 11 Sep 2005 02:07:25 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org>	<1126396015l.6300l.1l@werewolf.able.es> <20050910165659.5eea90d0.akpm@osdl.org>
In-Reply-To: <20050910165659.5eea90d0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> 
>>I can not ifup an interface while iptables is using it.
>>Is this expected behaviour ?
> 
> Maybe it's expected, but breaking existing userspace is a serious issue.

No, its not expected.

>>There is a possible bug (IMHO) in Mandrake initscripts, that start iptables
>>before network interfaces, but this had always worked.
>>
>>Any ideas ?

What's happening when you try to set the interface up? Please
provide output of ifup and strace of the failing command. Thanks.
