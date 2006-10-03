Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWJCK3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWJCK3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWJCK3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:29:35 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:31962 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964872AbWJCK3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:29:34 -0400
Date: Tue, 3 Oct 2006 12:28:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <w@1wt.eu>
cc: Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>, linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <20061002033531.GA5050@1wt.eu>
Message-ID: <Pine.LNX.4.61.0610031227420.32633@yvahk01.tjqt.qr>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> ppmd, also in Debian had better compression than lzma. PAQ8i has even
>> better compression, but isn't in Debian. See the maximumcompression web
>> site or other archive comparison tests.
>
>Interesting. But I suspect that you have not checked the compression time.
>PAQ8I for instance is between 100 and 300 times SLOWER than bzip2 to achieve
>about 30% smaller ! Given that the kernel already takes a very long time to
>compress with bzip2, it would take several hours to compress it with such
>tools. While they're very interesting proofs of concept for compression
>research, they're not suited to any real world usage !

There are lots of obscure compression formats that achieve somewhat 
better compression at the cost of MUCH more time (neglecting they are 
not too open), such as MS CAB and ACE.


Jan Engelhardt
-- 
