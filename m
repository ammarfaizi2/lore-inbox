Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUAIVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbUAIVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:36:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264389AbUAIVgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:36:51 -0500
Message-ID: <3FFF1EC4.7080406@zytor.com>
Date: Fri, 09 Jan 2004 13:36:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: viro@parcelfarce.linux.theplanet.co.uk, Ian Kent <raven@themaw.net>,
       autofs mailing list <autofs@linux.kernel.org>,
       "Ogden, Aaron A." <aogden@unocal.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <3FFC96FE.9050002@zytor.com> <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net> <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk> <3FFF03EA.4060603@sun.com> <3FFF07B2.70801@zytor.com> <3FFF1DA7.8060005@sun.com>
In-Reply-To: <3FFF1DA7.8060005@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
>
> Unless I'm missing something, implementing this as a seperate filesystem
> type still has the appropriate atomicity guarantees as long as the VFS
> support complex expiry, whereby userspace would tag submounts as being
> part of the overall expiry for a base mountpoint.
> 

It would, but it seems like a vastly more invasive change to the VFS
than ought to be necessary.

	-hpa

