Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSHXRIe>; Sat, 24 Aug 2002 13:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSHXRIe>; Sat, 24 Aug 2002 13:08:34 -0400
Received: from p50887F28.dip.t-dialin.net ([80.136.127.40]:43940 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316535AbSHXRId>; Sat, 24 Aug 2002 13:08:33 -0400
Date: Sat, 24 Aug 2002 11:12:27 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Arador <diegocg@teleline.es>
cc: Robert Love <rml@tech9.net>, <thunder@lightweight.ods.org>,
       <dag@newtech.fi>, <linux-kernel@vger.kernel.org>, <conman@kolivas.net>
Subject: Re: Preempt note in the logs
In-Reply-To: <20020824190250.796126ac.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.44.0208241109210.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Aug 2002, Arador wrote:
> I can see all those messages, too. A lot of tasks (if not all)
> seems to exit with a "note: task[PID] exited with preempt_count 1"

Symptoms confirmed, that is.

> > Do you use XFS?  If not, what fs?
> 
> Reiserfs

IMHO we can exclude reiserfs, at least the code must be clean. I'm on
2.4.19-rc5-aa1 w/reiserfs 3.6, which acts just the hell of a perfect
system. I'm serious. Of course it can be triggering.

We have to check
1. process kicking code
2. process killing code
3. memory allocation code
4. read/write code

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

