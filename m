Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRBPKyO>; Fri, 16 Feb 2001 05:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129546AbRBPKyE>; Fri, 16 Feb 2001 05:54:04 -0500
Received: from pat.uio.no ([129.240.130.16]:31122 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129175AbRBPKyA>;
	Fri, 16 Feb 2001 05:54:00 -0500
To: khairul sazaney <sazaney@magnifix.com.my>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs lockd: lockdsvc - invalid argument
In-Reply-To: <3A8CF682.B3F4F754@magnifix.com.my>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 16 Feb 2001 11:53:41 +0100
In-Reply-To: khairul sazaney's message of "Fri, 16 Feb 2001 17:44:34 +0800"
Message-ID: <shsy9v6526i.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == khairul sazaney <sazaney@magnifix.com.my> writes:

     > i just compile my linux 2.4.1 kernel in my red hat 7.1 ..after
     > i restart it..i found that when it's prompts FAILED - starting
     > NFS lock..and said that lockdsvc : invalid argument..what
     > should i do..sorry if this question is too easy for u guys..

That's because lockd starts automatically upon mount (again). The
rpc.lockd kickstarter in the init scripts is no longer needed.

Cheers,
  Trond
