Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbTCTQug>; Thu, 20 Mar 2003 11:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbTCTQug>; Thu, 20 Mar 2003 11:50:36 -0500
Received: from smtp-102.noc.nerim.net ([62.4.17.102]:42763 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S261340AbTCTQue>; Thu, 20 Mar 2003 11:50:34 -0500
Date: Thu, 20 Mar 2003 18:01:34 +0100
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, alexh@ihatent.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hard freeze with 2.5.65-mm1
Message-Id: <20030320180134.1f3e0d21.philippe.gramoulle@mmania.com>
In-Reply-To: <20030319191536.58ea9d35.akpm@digeo.com>
References: <20030319104927.77b9ccf9.philippe.gramoulle@mmania.com>
	<8765qfacaz.fsf@lapper.ihatent.com>
	<20030319182442.4a9fa86c.philippe.gramoulle@mmania.com>
	<877kav5ikv.fsf@lapper.ihatent.com>
	<20030319121909.74f957af.akpm@digeo.com>
	<20030320010319.GB1240@holomorphy.com>
	<20030319191536.58ea9d35.akpm@digeo.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws24 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a side note.

I rebooted with elevator=deadline this morning and i didn't experienced any
hard freeze since. Uptime is about 8 hours now ( both former freezes were with
elevator=as)

No xmms audio skips, very good overall feel, very good responsiveness
(openoffice,mozilla, news feed update,etc..)

Thanks,

Philippe


On Wed, 19 Mar 2003 19:15:36 -0800
Andrew Morton <akpm@digeo.com> wrote:

  | William Lee Irwin III <wli@holomorphy.com> wrote:
  | >
  | > $ less /proc/16657/wchan
  | > do_clock_nanosleep
  | 
  | There is a bug in do_clock_nanosleep().  I can reproduce it.  I'll fix it up
  | later today.
  | 
  | -
  | To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
  | the body of a message to majordomo@vger.kernel.org
  | More majordomo info at  http://vger.kernel.org/majordomo-info.html
  | Please read the FAQ at  http://www.tux.org/lkml/
  | 
