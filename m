Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTE0RZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTE0RZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:25:51 -0400
Received: from pop.gmx.net ([213.165.65.60]:51778 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263972AbTE0RZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:25:48 -0400
Message-ID: <3ED3A2AB.3030907@gmx.net>
Date: Tue, 27 May 2003 19:38:51 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva> <3ED372DB.1030907@gmx.net> <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Tue, 27 May 2003, Carl-Daniel Hailfinger wrote:
> 
>>Marcelo Tosatti wrote:
>>
>>>On Mon, 26 May 2003, manish wrote:
>>>>All the bonnie process and any other process (like df, ps -ef etc.) are
>>>>hung in __lock_page. Breaking into kdb, I observe the following for one
>>
>>Following is SysRq-T output for stuck processes during such a pause from
>>Christian Klose. Only processes in D state are listed for brevity.
>>Especially the last two call traces are interesting.
> 
> A "pause" is perfectly fine (to some extent, of course), now a hang is
> not. Is this backtrace from a hanged, unusable kernel or ?

AFAIK, the kernel is not unusable, but a 20 second pause with no disk
access at all is not nice either.


Regards,
Carl-Daniel

