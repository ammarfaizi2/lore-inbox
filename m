Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbTGHR2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266937AbTGHR2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:28:08 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13253 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264854AbTGHR2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:28:05 -0400
Date: Tue, 08 Jul 2003 10:42:44 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Matthew Wilcox <willy@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
cc: hannal@us.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
Message-ID: <27230000.1057686164@w-hlinder>
In-Reply-To: <20030708172028.GB1939@parcelfarce.linux.theplanet.co.uk>
References: <16138.53118.777914.828030@charged.uio.no> <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk> <16138.56467.342593.715679@charged.uio.no> <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk> <20030708164426.GB10004@www.13thfloor.at>
 <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk> <20030708170628.GA13593@www.13thfloor.at> <20030708172028.GB1939@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, July 08, 2003 06:20:28 PM +0100 Matthew Wilcox <willy@debian.org> wrote:

> On Tue, Jul 08, 2003 at 07:06:28PM +0200, Herbert Poetzl wrote:
>> every change (if it's not a bugfix, and even those) bear
>> a risk, what I like about the fastwalk patch is not the
> 
> exactly.  2.4 is not the place for cleanups that make the code easier
> to read because those cleanups can introduce new bugs.
> 

Im not going to fight too hard for this. If people want it removed
that is OK. I pushed it because dcache_rcu was not going to be 
accepted and Fastwalk is a fair second to dcache_rcu. The change Trond 
pointed out was added by Al Viro after fastwalk was included in 2.5.11
which I backported.

Hanna

