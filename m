Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTHYKfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTHYKfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:35:03 -0400
Received: from main.gmane.org ([80.91.224.249]:41872 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261692AbTHYKe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:34:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 12:34:57 +0200
Message-ID: <yw1x65kmc9f2.fsf@users.sourceforge.net>
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net>
 <20030825094240.GJ16080@Synopsys.COM>
 <200308252016.13315.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:DtTilP880rIYZW1bF4GC7N4kplE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

>> > XEmacs still spins after running a background job like make or grep.
>> > It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
>> > as often, or as long time as with O16.3, but it's there and it's
>> > irritating.
>>
>> another example is RXVT (an X terminal emulator). Starts spinnig after
>> it's child has exited. Not always, but annoyingly often. System is
>> almost locked while it spins (calling select).
>
> What does vanilla kernel do with these apps running? Both immediately after 
> the apps have started up and some time (>1 min) after they've been running?

Vanilla test1 has the spin effect.  Test2 doesn't.  I haven't tried
vanilla test3 or test4.  As I've said, the O16.2-O16.3 patch
introduced the problem.  With that patch reversed, everything is
fine.  What problem does that patch fix?

-- 
Måns Rullgård
mru@users.sf.net

