Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTAJRGo>; Fri, 10 Jan 2003 12:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTAJRGo>; Fri, 10 Jan 2003 12:06:44 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:6414
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265578AbTAJRGh>; Fri, 10 Jan 2003 12:06:37 -0500
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
From: Robert Love <rml@tech9.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org,
       daniel.ritz@alcatel.ch
In-Reply-To: <Pine.LNX.4.44.0301101628460.1434-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301101628460.1434-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1042218917.722.15.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-3) 
Date: 10 Jan 2003 12:15:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 11:34, Hugh Dickins wrote:

> Indeed!  I think that was Andi volunteering :-}
> But we should let rml defend his wchan.

Well, of course I want to keep it - but I am biased :)

I think its a simple export that gives us a neat feature.  Additionally,
from the procps perspective, it saves us from having to parse System.map
for each process.  In fact, it means we do not need a System.map at all
for any procps functionality.

I guess Linus at least mildly liked it too, since he merged it.

But if its such a performance crippling item perhaps it does need to be
removed (or somehow restricted).

I do agree that, if possible, wchan should be kept simple... so, is
everyone else for the removal of /proc/pid/wchan ? :-(

	Robert Love

