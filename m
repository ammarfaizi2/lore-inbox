Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTJ0NTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 08:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTJ0NTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 08:19:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:5830 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261705AbTJ0NTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 08:19:40 -0500
Message-ID: <3F9D1B6B.901@namesys.com>
Date: Mon, 27 Oct 2003 16:19:39 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org
Subject: Re: fsstress causes memory leak in test6, test8
References: <Pine.LNX.4.58.0310251842570.371@morpheus>	<20031026170241.628069e3.akpm@osdl.org>	<20031027121609.GA27611@redhat.com> <16285.5092.216272.470811@laputa.namesys.com>
In-Reply-To: <16285.5092.216272.470811@laputa.namesys.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Dave Jones writes:
> > On Sun, Oct 26, 2003 at 05:02:41PM -0800, Andrew Morton wrote:
> > 
> >  > It is not a "leak" as such - the dentries will get shrunk in normal usage
> >  > (create enough non-dir dentries and the "leaked" directory dentries will
> >  > get reclaimed).  The really deep directories which fsstress creates
> >  > demonstrated the bug.
> > 
> > This could explain the random reiserfs oopses/hangs I was seeing several
> > months back after running fsstress for a day or so. The reiser folks
>
>This could explain hangs, but hardly oopses. System just freezes due to
>out-of-memory.
>
Ah, thanks Nikita.

-- 
Hans


