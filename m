Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbTF1RP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 13:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbTF1RP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 13:15:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:47242 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265300AbTF1RPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 13:15:25 -0400
Date: Sat, 28 Jun 2003 10:29:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mm1 falling over in SDET
Message-Id: <20030628102959.455f689f.akpm@digeo.com>
In-Reply-To: <45120000.1056810681@[10.10.2.4]>
References: <45120000.1056810681@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2003 17:29:42.0341 (UTC) FILETIME=[DC194F50:01C33D9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> The killer SDET has got you, but this is all I got from the chewed
> remains. Maybe the EIP is enough? ;-) I guess that's a NULL ptr
> dereference, though garbled somewhat.
> 
> Unable to handle kernel <1pa>Uginnabgl re eqtoue hsta ndatle  vikertrnuaell  NadULdrL espos inaftecr71 d11er0
> er penricent iantg v eiirtp:ua            ef
>  cad01drc4es37s a             l
> 000*0pd00e 0     0
> 00 p00ri00nt00in
> g Oeiopps: 0000 [#1]
> SMP 
> CPU:    -266755620
> EIP:    0060:[<c01c437a>]    Not tainted VLI
> EFLAGS: 00010083
> EIP is at drive_stat_acct+0x76/0xcc

Interesting CPU number.

The mangled output is supposed to be fixed.  Looks like it
only partially worked.  Why doesn't someone fix this?

No, it ain't a lot of use really.  Is it repeatable?  If
so does changing elevators make it go away?
