Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSHXR5K>; Sat, 24 Aug 2002 13:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSHXR5K>; Sat, 24 Aug 2002 13:57:10 -0400
Received: from p50887F28.dip.t-dialin.net ([80.136.127.40]:1189 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316586AbSHXR5J>; Sat, 24 Aug 2002 13:57:09 -0400
Date: Sat, 24 Aug 2002 12:01:04 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Robert Love <rml@tech9.net>
cc: Arador <diegocg@teleline.es>, <dag@newtech.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <conman@kolivas.net>
Subject: Re: Preempt note in the logs
In-Reply-To: <1030211284.1935.4991.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208241157590.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24 Aug 2002, Robert Love wrote:
> It is caused by any mismatched locking - it is a good debugging check
> regardless of preemption.

Do you think it's useful to temporarily put a lock counter into struct 
task (TEMPORARILY, Linus, temporarily!) and check that as well? Maybe that 
will point us something.

Or we should extend that whole crap a bit so we could see exactly what 
caused the preemption count to rise. I don't know if we can do that, but 
we can try doing that.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

