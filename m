Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129337AbQKGR6v>; Tue, 7 Nov 2000 12:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbQKGR6m>; Tue, 7 Nov 2000 12:58:42 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:52746 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129213AbQKGR60>;
	Tue, 7 Nov 2000 12:58:26 -0500
Date: Tue, 7 Nov 2000 09:58:46 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: tytso@mit.edu, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011071053211.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.21.0011070957370.2811-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Umm, so why does this not happen with 2.2.X at all? Also the system is
> not really stressed, but I simply do startx, inside an xterm go to
> some random source, make -j, wait till the compile is complete and then
> switch back to the console - its just that it seems that swapped out
> X server or console stuff causes this.
> 
> I consider this quite a showstopper for 2.4.0.

Actually I just thought about it. Do you DRI running. When you have DRI
enabled you shouldn't VT switch. It is a design flaw in DRI and the
console system :-(. Disable DRI you you will be fine.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
