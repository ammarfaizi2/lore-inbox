Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTIVBBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 21:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbTIVBBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 21:01:09 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:6804 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S262695AbTIVBBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 21:01:07 -0400
Message-ID: <3F6E49D2.8060901@comcast.net>
Date: Sun, 21 Sep 2003 18:01:06 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: Re: 2.6.0-test5-mm3 & XFS FS Corruption (or not?)
References: <3F6DC819.8060003@comcast.net>  <3F6DE929.4040904@comcast.net> <1064173697.2285.4.camel@laptop.americas.sgi.com>
In-Reply-To: <1064173697.2285.4.camel@laptop.americas.sgi.com>
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:

> 
> If I am correct, test5-mm3 contains a bad version of the xfs code, there
> was a bug where the i_flags field was setup from an uninitialized stack
> variable. mm3 came out during the two days this was in Linus's tree.
> I had some very odd behavior with this code base, rm -r -f would try and
> cd into files and other bizzare things, files could appear to be
> immutable or append only or things they were not. This sounds like
> similar behavior you that you saw. It is fixed in the latest code Linus
> has.
> 
> Steve

Thanks for the reply Steve. I'm guessing that this code hasn't hit CVS
yet, as I can still reproduce it with a current CVS @ 9/21/03 ~ 17:30
PST  Sounds like this is a known issue, so I'll just go back to the xfs
code from -mm2 for now.

-Walt



