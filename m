Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTEFIL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTEFIL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:11:57 -0400
Received: from pointblue.com.pl ([62.89.73.6]:1298 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262009AbTEFILz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:11:55 -0400
Subject: Re: 2.5.68-bk11: .text.exit errors in .altinstructions
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Andi Kleen <ak@muc.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506051348.GA1338@averell>
References: <20030502171355.GU21168@fs.tum.de>
	 <1052175893.25085.9.camel@nalesnik> <20030506005326.GB18146@averell>
	 <20030505191409.2e2a265c.akpm@digeo.com>  <20030506051348.GA1338@averell>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1052209105.2810.1.camel@nalesnik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 09:18:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 06:13, Andi Kleen wrote:
> On Tue, May 06, 2003 at 04:14:09AM +0200, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > > On Tue, May 06, 2003 at 01:04:55AM +0200, Grzegorz Jaskiewicz wrote:
> > > > I've got the same problem with 2.5.69:
> > > 
> > > Use the same workaround. Remove .text.exit from the DISCARD
> > > section in your vmlinux.lds.S
> > > 
> > > Really the problem is unfixable without binutils changes in other
> > > ways, sorry.
> > 
> > How's about we drop .text.exit at runtime, along with .text.init?
> 
> Good idea :-) That could work.
works for me :)

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

