Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTAIIAT>; Thu, 9 Jan 2003 03:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTAIIAT>; Thu, 9 Jan 2003 03:00:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:51657 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261872AbTAIIAS>;
	Thu, 9 Jan 2003 03:00:18 -0500
Message-ID: <3E1D2E12.27417587@digeo.com>
Date: Thu, 09 Jan 2003 00:08:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rms@gnu.org
CC: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
References: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org>
		(message from Andre Hedrick on Fri, 3 Jan 2003 15:01:51 -0800 (PST)) <E18WX7P-0001cV-00@fencepost.gnu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2003 08:08:54.0124 (UTC) FILETIME=[59F95AC0:01C2B7B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Stallman wrote:
> 
> ...
> That's not the FSF's view.  Our view is that just using structure
> definitions, typedefs, enumeration constants, macros with simple
> bodies, etc., is NOT enough to make a derivative work.  It would take
> a substantial amount of code (coming from inline functions or macros
> with substantial bodies) to do that.

The last part doesn't make a lot of sense.

Use of an inline function is just that: usage.  It matters not at
all whether that function is invoked via inline integration or via
subroutine call.  This is merely an implementation detail within
the code which provides that function.

Such functions are part of the offered API which have global scope,
that's all.
