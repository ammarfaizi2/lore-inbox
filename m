Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUAFX0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbUAFX0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:26:33 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58803 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266097AbUAFX0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:26:23 -0500
Message-ID: <3FFB441D.3010908@namesys.com>
Date: Wed, 07 Jan 2004 02:26:21 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Mike Fedyk <mfedyk@matchmail.com>,
       "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>,
       linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <Pine.LNX.4.56.0401062251290.8384@jju_lnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0401062251290.8384@jju_lnx.backbone.dif.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>
>
>Also, I did a build of fs/reiserfs/ both with and without the above patch,
>and then did a disassemble of inode.o (objdump -d) and compared the
>generated code for reiserfs_get_block , and the generated code is
>byte-for-byte identical in both cases, which means that gcc realizes that
>the if() statement will never execute and optimizes it away in any case.
>  
>
I think you have done too much work.;-)

Thanks though. 

The only reason we are slow in processing your patch and forwarding it 
to Linus is that the Russian Christmas is today....

-- 
Hans


