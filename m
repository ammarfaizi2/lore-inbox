Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbTKJTI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTKJTI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:08:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23057 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264056AbTKJTIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:08:55 -0500
Message-ID: <3FAFE22B.3030108@zytor.com>
Date: Mon, 10 Nov 2003 11:08:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Davide Libenzi <davidel@xmailserver.org>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random>
In-Reply-To: <20031110183722.GE6834@x30.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> you must pick file2 before file1:
> 
> 	you:
> 
> 	do
> 		get file2
> 		get repo-file1-j
> 		get file1
> 	while file2 != file1 && sleep 10
>

Okay... I'm starting to think the sequencing requirements on these files
may be hard to maintain across multiple levels of rsync... but perhaps
I'm wrong, in particular if 'file2' sorts hierachially-lexically last
and 'file1' first...

	-hpa

