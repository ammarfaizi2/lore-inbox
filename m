Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUBDAvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUBDAvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:51:12 -0500
Received: from www.trustcorps.com ([213.165.226.2]:42001 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S266184AbUBDAvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:51:10 -0500
Message-ID: <4020416B.3050301@hcunix.net>
Date: Wed, 04 Feb 2004 00:48:43 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz>
In-Reply-To: <20040204004318.GA253@elf.ucw.cz>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,


> 
> Well, doing it on-demand means one less config option, and possibility
> to include it into 2.7... It should be easy to have tiny patch forcing
> that option always own for your use...

Works for me. Should I implement the chattr 's' handling then for the 
data blocks? Or do you think it should also include the meta-data 
deletion as well?


peace,

--gq
