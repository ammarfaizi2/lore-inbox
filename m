Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTE0RYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTE0RYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:24:16 -0400
Received: from holomorphy.com ([66.224.33.161]:19176 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262818AbTE0RYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:24:16 -0400
Date: Tue, 27 May 2003 10:36:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527173649.GM8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
	Christian Klose <christian.klose@freenet.de>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva> <3ED372DB.1030907@gmx.net> <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Carl-Daniel Hailfinger wrote:
>> Following is SysRq-T output for stuck processes during such a pause from
>> Christian Klose. Only processes in D state are listed for brevity.
>> Especially the last two call traces are interesting.

On Tue, May 27, 2003 at 02:27:00PM -0300, Marcelo Tosatti wrote:
> A "pause" is perfectly fine (to some extent, of course), now a hang is
> not. Is this backtrace from a hanged, unusable kernel or ?

This sounds like deadlocked proceses, but not a whole system hang.
Sounds like a correctness issue, not a performance issue.


-- wli
