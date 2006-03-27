Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWC0CzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWC0CzB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 21:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWC0CzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 21:55:01 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:20099 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932179AbWC0CzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 21:55:00 -0500
Message-ID: <44275391.40501@cfl.rr.com>
Date: Sun, 26 Mar 2006 21:53:05 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Phillip Hellewell <phillip@hellewell.homeip.net>
CC: Michael Halcrow <lkml@halcrow.us>, Michael Halcrow <mhalcrow@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com
Subject: Re: eCryptfs Design Document
References: <20060324222517.GA13688@us.ibm.com> <442599D5.806@cfl.rr.com> <20060325195015.GA8174@halcrow.us> <4426CB05.2070604@cfl.rr.com> <20060326180458.GA10056@halcrow.us> <20060327000522.GA11655@hellewell.homeip.net>
In-Reply-To: <20060327000522.GA11655@hellewell.homeip.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Hellewell wrote:
> Again I concur with Mike.  Iterative hashing is a very common technique,
> and is very effective against this type of dictionary attack.  If you
> hash 1000 times, then an attack that normally could check 1 million
> passwords per second would now only be able to check 1000 passwords per
> second.
> 
> Without iterative hashing, as computers get faster, so would dictionary
> attacks, and then people would have to keep using longer and longer
> passwords to be as effective.  Iterative hashing "levels the playing
> field" in a way.
> 


Except that I believe you can write code to compute the nth hash in O(1) 
time rather than O(n) time, so that kind of defeats the purpose, though 
I'm no expert so I could be wrong.


