Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTJ0MbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTJ0MbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:31:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:28101 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261601AbTJ0MbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:31:18 -0500
Message-ID: <3F9D1014.5000006@namesys.com>
Date: Mon, 27 Oct 2003 15:31:16 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Burton Windle <bwindle@fint.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: fsstress causes memory leak in test6, test8
References: <Pine.LNX.4.58.0310251842570.371@morpheus> <20031026170241.628069e3.akpm@osdl.org> <20031027121609.GA27611@redhat.com>
In-Reply-To: <20031027121609.GA27611@redhat.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Sun, Oct 26, 2003 at 05:02:41PM -0800, Andrew Morton wrote:
>
> > It is not a "leak" as such - the dentries will get shrunk in normal usage
> > (create enough non-dir dentries and the "leaked" directory dentries will
> > get reclaimed).  The really deep directories which fsstress creates
> > demonstrated the bug.
>
>This could explain the random reiserfs oopses/hangs I was seeing several
>months back after running fsstress for a day or so. The reiser folks
>were scratching their heads, and we even put it down to flaky hardware
>or maybe even a CPU bug back then.
>  
>
This means we failed to make a properly serious effort at replicating it 
on our hardware.  My apologies for that.  Who at Namessys was it that 
investigated your bug report?

-- 
Hans


