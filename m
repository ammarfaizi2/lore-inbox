Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUJYRfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUJYRfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUJYRfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:35:37 -0400
Received: from [195.23.16.24] ([195.23.16.24]:61147 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261214AbUJYRdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:33:54 -0400
Message-ID: <417D38F7.1040204@grupopie.com>
Date: Mon, 25 Oct 2004 18:33:43 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: "Nico Augustijn." <kernel@janestarz.com>, hvr@gnu.org,
       clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase
References: <200410251354.31226.kernel@janestarz.com> <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>
In-Reply-To: <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.34; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 25 Oct 2004 13:54:31 +0200, "Nico Augustijn." said:
> 
> 
>>But all that takes some searching. And the passphrase is also XOR-ed with the
>>first 32 bytes of /dev/nvram.
> 
> 
> So if something touches the first 32 bytes of NVRAM, your data evaporates?
> 
> Is this considered a desirable result?

I don't have any feelings about this patch, but it seems to me that you 
could always store the contents of the nvram somewhere "safe" (you could 
even write them down and take it to a safe deposit box in a bank :) ), 
and, if those contents happen to change, you could always write them 
again...

Just my 0.02 euros,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
