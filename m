Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSBMXkb>; Wed, 13 Feb 2002 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289166AbSBMXkW>; Wed, 13 Feb 2002 18:40:22 -0500
Received: from bagheera.aus.deuba.com ([203.0.62.7]:61132 "EHLO
	imr1.aus.deuba.com") by vger.kernel.org with ESMTP
	id <S289167AbSBMXkF>; Wed, 13 Feb 2002 18:40:05 -0500
Date: Thu, 14 Feb 2002 10:31:52 +1100 (EST)
From: Luke Burton <luke.burton@db.com>
X-X-Sender: <lukeburt@dbsydn2001.aus.deuba.com>
Reply-To: <luke.burton@db.com>
To: <linux-kernel@vger.kernel.org>
cc: <phillips@bonn-fries.net>
Subject: Re: RFC: /proc key naming consistency
Message-ID: <Pine.LNX.4.33.0202141020140.5260-100000@dbsydn2001.aus.deuba.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What do you think about the idea earlier in this thread of going with
> shell-parsable key value pairs?  I find that idea really attractive,
> but there's the issue of breaking utilities (kde control panel?) that
> already parse the existing format.

Shell parseable /proc/* entries would be so much more elegant to deal with
compared to the old system. I would guess that maintainers for things like
KDE would jump at the opportunity to decrease the complexity of their
code.

A compatibility mode might be useful. Either a straight config option, or
perhaps something more sophisticated. Idea: perhaps proc functions
installed with create_proc_read_entry could, rather than just write
strings to buffers, return a list of key/value pairs which is rendered in
some configurable format by a new function, like "proc_render_values".
proc_render_values could use a column format like it does now, or a shell
parseable foo=blah\n format.

Or even XML. Ouch! No need to throw things at me!

Regards,

Luke.

-- 

Ash OS durbatulk, ash OS gimbatul,
Ash OS thrakatulk, agh burzum-ishi krimpatul!
Uzg-Microsoft-ishi amal fauthut burguuli.


