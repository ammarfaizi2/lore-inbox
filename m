Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUASXU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUASXU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:20:58 -0500
Received: from smtp0.libero.it ([193.70.192.33]:54009 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S263793AbUASXUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:20:33 -0500
Message-ID: <400C650C.1070303@gentoo.org>
Date: Tue, 20 Jan 2004 00:15:24 +0100
From: Luca Barbato <lu_zero@gentoo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: cryptoapi-devel@kerneli.org, linux-kernel@vger.kernel.org
Subject: Re: gcloop: compressed loopback support for 2.6
References: <3F5F4F96.4050000@gentoo.org> <400C05E1.70005@gentoo.org> <20040119164139.GR1748@srv-lnx2600.matchmail.com>
In-Reply-To: <20040119164139.GR1748@srv-lnx2600.matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Mon, Jan 19, 2004 at 05:29:21PM +0100, Luca Barbato wrote:
> 
> 
> 
> Is/will knoppix be using this this as well or is this a fork?
> 
This started as fork from the cloop-0.6x.
Now the file format is almost the same, but the code is quite different: 
the only thing that remains is the the basic logic and the block unpacker.
The current code is currently under testing for gentoo livecd and other 
projects that use the same tecnology, at least that I'm aware.
If Klaus thinks that gcloop is good enough for his knoppix I'd be glad.

Currently gcloop-0.99 uses 32bit indexes since my target are livecd, for 
livedvd would be better use the newer cloop-2.0/1.0 file format with 
64bit indexes.

gcloop isn't file format compatible with the old cloop-0.68 fileformat 
since I had to use in a different way the index and I prefer ucl instead 
of zlib.

lu

-- 
Luca Barbato
Developer
Gentoo Linux				http://www.gentoo.org/~lu_zero


