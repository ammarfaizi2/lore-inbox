Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUBDAgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266230AbUBDAgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:36:15 -0500
Received: from www.trustcorps.com ([213.165.226.2]:33041 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S266223AbUBDAgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:36:10 -0500
Message-ID: <40203DE1.3000302@hcunix.net>
Date: Wed, 04 Feb 2004 00:33:37 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz>
In-Reply-To: <20040203222030.GB465@elf.ucw.cz>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,


> Perhaps this should still be controlled by (chattr(1)) [its already
> documented, just not yet implemented].
> 
>        When a file with the `s' attribute set is deleted, its blocks
> 	are zeroed and written back to the disk.
> 
> ...at which point config option is not really neccessary.
> 

You're not the first person to mention this to me, Pádraig, brought this 
up on the day I posted. I certainly thing the 's' options should be 
implemented, however for a privacy patch I believe that the user 
shouldn't have to intervene to ensure a file is securely erased. It 
makes more sense to me, as a lazy person, that the file system should be 
set to always remove the file content... that way the user doesn't need 
to get involved.

All that said, the user's content is something that the user could be 
considered responsible for erasing themselves. The meta-data is the part 
of the file which they dont' have access to, so having privacy 
capabilities for meta-data erasure is a requirement. User data 
erasure... I can take it or leave it. I think it should be automatic if 
at all, but I'm not really that bothered about it.


peace,

--gq

