Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVJKEpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVJKEpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVJKEpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:45:46 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:17634 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751332AbVJKEpp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:45:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WEQHhHd3e1lwg7F+QILZwlM/TjUjzFhuPot+XDuqcHfYyMPpgAdwDoK9wisLe7RJ2jBlfNQaaXor1dzF8hPrkh/pkRtqNAPgQgY0rA7bpS90n8DRuHIA/S1kUbHBgwcSk/qr0pyZzm7ueFNyydip+n6/0TXJ1tC/fMtXqPNAsVE=
Message-ID: <5bdc1c8b0510102145k3b05c00dm8e3e770c5eee2ee4@mail.gmail.com>
Date: Mon, 10 Oct 2005 21:45:44 -0700
From: Mark Knecht <markknecht@gmail.com>
To: chaosite@gmail.com
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <434B3803.2030803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
	 <434B3803.2030803@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Matan Peled <chaosite@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Mark Knecht wrote:
> > Well, I'm disappointed again. Some xruns came but no additional data
> > was put into the dmesage file:
>
> "dmesage file"? You mean, "/var/log/dmesg"? No, thats not the file you want...
> At least here, that file contains the logs as they were when the boot finishes.
>
> The information you want can be retrieved by running the command (actual program
> to run, type it in a terminal) "dmesg".

Right, sorry. Obviously bad typing on my part. I am running 'dmesg' at
the command line to get the traces. My bad...

Anyway, these latencies seem understood at this point. They are just
the timer that you set in the kernel hacking section. No big deal.
However, none of the messages yet give any clues (that I understand)
as to the cause of the timing misses I'm seeing with 2.6.14-rc3-rt13.
I shall look into a 2.6.14-rc4-rtX tomorrow.

Cheers,
Mark
