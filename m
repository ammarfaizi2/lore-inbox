Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbTIKVdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTIKVdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:33:40 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43538
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261551AbTIKVdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:33:39 -0400
Date: Thu, 11 Sep 2003 14:33:41 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac2
Message-ID: <20030911213341.GE26618@matchmail.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <200309092334.h89NYxh18536@devserv.devel.redhat.com> <bjqoo7$tp5$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bjqoo7$tp5$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 09:16:55PM +0000, Bill Davidsen wrote:
> In article <200309092334.h89NYxh18536@devserv.devel.redhat.com>,
> Alan Cox  <alan@redhat.com> wrote:
> | (No its not course start time quite yet..)
> | 
> | Various little fixups and tidying bits. Some of these probably want to
> | get pushed on to Marcelo eventually - the small bits and the CMPCI update
> | certainly.
> | 
> | Linux 2.4.22-ac2
> | o	Taint on sii6512 module that someone 		(Arjan van de Ven)
> | 	"accidentally" marked as GPL but is nonfree
> 
> I'm happy to say I haven't ever had to use a tainted kernel, but is this
> clearly marked at config time? Should there be a USE_TAINTED_CODE
> global, like the EXPERIMENTAL and BROKEN options?

Is this "module" in the kernel tree?

If it is, how does it live there at all?  Maybe it's an Open Source license,
that lets you distribute the code, but because of incompatabilities has to
be built as a module?
