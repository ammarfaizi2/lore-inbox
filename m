Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTE0SP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbTE0SOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:14:04 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:31750 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264071AbTE0SMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:12:55 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 20:25:11 +0200
User-Agent: KMail/1.5.2
Cc: manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305271958.51924.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271516220.756@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271516220.756@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272025.11495.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 20:16, Marcelo Tosatti wrote:

Hi Marcelo,

> > I repeat this now for the $high_number'th time ;):
> > - 2.4.18 worked perfect
> > - 2.4.19-pre not
> Thats very useful information. Can you track down which -pre introduced
> the hangs?
If I am not on drugs and my last test was not under drugs, the causing patch 
is this one:

http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/block/ll_rw_blk.c@1.29?nav=index.html|ChangeSet@-2y|cset@1.160|hist/drivers/block/ll_rw_blk.c

ciao, Marc

