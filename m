Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbULPSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbULPSsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbULPSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:48:37 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59854 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261982AbULPSsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:48:18 -0500
Message-ID: <41C1D870.2020407@namesys.com>
Date: Thu, 16 Dec 2004 10:48:16 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com>	 <1103059622.2999.17.camel@grape.st-and.ac.uk>	 <41BFC1C5.1070302@slaphack.com> <1103102854.30601.12.camel@pear.st-and.ac.uk> <41C0CF3B.1030705@slaphack.com>
In-Reply-To: <41C0CF3B.1030705@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
>
> Speaking of which, how much speed is lost by starting up a process?
>
> The idea of caching is that running
>
> cat *; cat *; cat *; cat *; cat *
>
> is probably slower than
>
> cat * > baz; cat baz; cat baz; cat baz; cat baz; cat baz

Only for small files where the per file overhead of a read is significant.


