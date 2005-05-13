Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVEMLvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVEMLvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVEMLvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:51:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262328AbVEMLvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:51:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <86C557AE41D8C0y.matsu@jp.fujitsu.com> 
References: <86C557AE41D8C0y.matsu@jp.fujitsu.com> 
To: Yoshihiro MATSUYAMA <y.matsu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FRV: Add defconfig 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.1
Date: Fri, 13 May 2005 12:50:59 +0100
Message-ID: <27117.1115985059@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoshihiro MATSUYAMA <y.matsu@jp.fujitsu.com> wrote:

> Would you check this configuration?

It looks reasonable; it's not quite the one I'd choose, but then I doubt most
people would be sticking IDE controllers into their board.

> I've confirmed boot on FR451 (MB93091-CB70 CPU board+ MB93091-MB00 
> motherboard).
> 
> ...loadable module support needs some works.
> Do you have a plan on this?

I hadn't really thought about it much. I don't bother with modules normally
and just build everything straight in so that I can use the gdbstub on them
more easily. I'll have a look at it at some point. It shouldn't be hard to do.

David
