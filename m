Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTLLUVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTLLUVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:21:32 -0500
Received: from [66.35.146.201] ([66.35.146.201]:47121 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id S261928AbTLLUVb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:21:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: walt <walt@nea-fast.com>
Organization: NEA
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6-test11  build error (fs/proc/array.c gcc 2.96 again!)
Date: Fri, 12 Dec 2003 15:21:22 -0500
User-Agent: KMail/1.4.3
Cc: marco.roeland@xs4all.nl, linux-kernel@vger.kernel.org
References: <200312121159.23972.walt@nea-fast.com> <200312121502.58555.walt@nea-fast.com> <20031212120302.6f58dafe.rddunlap@osdl.org>
In-Reply-To: <20031212120302.6f58dafe.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200312121521.22091.walt@nea-fast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 03:03 pm, Randy.Dunlap wrote:
> On Fri, 12 Dec 2003 15:02:58 -0500 walt <walt@nea-fast.com> wrote:
> | On Friday 12 December 2003 01:13 pm, Marco Roeland wrote:
> | > On Friday december 12th 2003 walt wrote:
> | > > I got the following when trying to compile 2.6.0-test11. Config is
> | > > attached.
> | > >
> | > > [internal compiler error for fs/proc/array.c]
> |
> | Thanks Marco!
> |
> | FYI - I removed
> | Kernel .config support (IKCONFIG)
> | and it compiled fine.
>
> You disabled IKCONFIG --> with or without applying the patch <-- ??
> and it compiled fine...

without the patch. Since it was with fs/proc I just looked to see what 
"strange" selection I had made which involved the proc file system. I removed 
it, started make bzImage,  and went to lunch before I received the email from 
marco.

walt
