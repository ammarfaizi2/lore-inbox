Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSCSWKi>; Tue, 19 Mar 2002 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293075AbSCSWK2>; Tue, 19 Mar 2002 17:10:28 -0500
Received: from pat.uio.no ([129.240.130.16]:39849 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S293060AbSCSWKM>;
	Tue, 19 Mar 2002 17:10:12 -0500
To: linux-kernel@ton.iguana.be (Ton Hospel)
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<200203180707.g2I771Z00657@mule.m17n.org>
	<shs8z8qb8c5.fsf@charged.uio.no>
	<200203180933.g2I9XTg07727@mule.m17n.org>
	<15509.47571.248407.537415@charged.uio.no>
	<a77m99$kjj$1@post.home.lunix>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 19 Mar 2002 23:10:00 +0100
Message-ID: <shsu1rci4zr.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ton Hospel <linux-kernel@ton.iguana.be> writes:


     > <HINT_HINT> well, the only reasons I still use unfsd is
     > link_relative and re-export </HINT_HINT>

Link_relative should be very easy to implement: the only reason I can
think why it hasn't been done yet is that it is so rarely useful that
nobody has bothered.

As for re-exporting: that can be done pretty easily too unless of
course you actually expect it to be reliable. The tough cookie is to
get it to survive server reboots.
Then again, I'm not sure unfsd was too good at handling that sort of
thing either...

Cheers,
  Trond
