Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbTAPRL5>; Thu, 16 Jan 2003 12:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTAPRL5>; Thu, 16 Jan 2003 12:11:57 -0500
Received: from angband.namesys.com ([212.16.7.85]:13696 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266760AbTAPRL4>; Thu, 16 Jan 2003 12:11:56 -0500
Date: Thu, 16 Jan 2003 20:20:48 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org,
       eazgwmir@umail.furryterror.org, viro@math.psu.edu
Subject: Re: [2.4] VFS locking problem during concurrent link/unlink
Message-ID: <20030116202048.A1109@namesys.com>
References: <20030116140015.A17612@namesys.com> <1042731580.31099.2195.camel@tiny.suse.com> <20030116184352.A32192@namesys.com> <1042732927.31100.2205.camel@tiny.suse.com> <15910.55436.680525.450310@laputa.namesys.com> <1042734151.31095.2211.camel@tiny.suse.com> <20030116200341.A1002@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030116200341.A1002@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 16, 2003 at 08:03:41PM +0300, Oleg Drokin wrote:
> > They inc the link count in ext2_link before scheduling.  The patch below
> > is what I had in mind, but is untested.
> It does not change anything.

Err, I mean I still can reproduce the problem with this patch.

Bye,
    Oleg
