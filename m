Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUCRGjR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 01:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbUCRGjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 01:39:17 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:43172 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262424AbUCRGif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 01:38:35 -0500
Message-ID: <405943DA.9030202@stesmi.com>
Date: Thu, 18 Mar 2004 07:38:18 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Long <scott_long@adaptec.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-raid@vger.kernel.org, "Gibbs, Justin" <justin_gibbs@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com> <4058C089.9060603@adaptec.com> <200403172245.31842.bzolnier@elka.pw.edu.pl> <4058EBEC.8070309@adaptec.com>
In-Reply-To: <4058EBEC.8070309@adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

<snip beginning of discsussion about DDF, etc>

> With DM, what happens when your initrd gets accidentally corrupted?
> What happens when the kernel and userland pieces get out of sync?
> Maybe you are booting off of a single drive and only using DM arrays
> for secondary storage, but maybe you're not.  If something goes wrong
> with DM, how do you boot?

Tell me something... Do you guys release a driver for WinXP as an
example? You don't have to answer that really as it's obvious that
you do. Do you in the installation program recompile the windows
kernel so that your driver is monolithic? The answer is most presumably
no - that's not how it's done there.

Ok. Your example states "what if initrd gets corrupted" and my example
is "what if you driver file(s) get corrupted?" and my example
is equally important to a module in linux as it is a driver in windows.

Now, since you do supply a windows driver and that driver is NOT
statically linked to the windows kernel why is it that you believe
a meta driver (which MD really is in a sense) needs special treatment
(static linking into the kernel) when for instance a driver for a piece
of hardware doesn't? If you have disk corruption so far that your
initrd is corrupted I would seriously suggest NOT booting that OS
that's on that drive regardless of anything else and sticking it
in another box OR booting from rescue media of some sort.

// Stefan
