Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbTHQNRU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270093AbTHQNRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:17:20 -0400
Received: from main.gmane.org ([80.91.224.249]:10438 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270065AbTHQNRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:17:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [BUG]  Serious scheduler starvation
Date: Sun, 17 Aug 2003 15:17:17 +0200
Message-ID: <yw1xada8v2xu.fsf@users.sourceforge.net>
References: <yw1xekzkv5yv.fsf@users.sourceforge.net> <200308172252.52464.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Aj2Cb2WqtELktGdv0QJvUt1YuNQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

>> First the machine details.  It's a Pentium4 running at 2 GHz.  Linux
>> version 2.6.0-test3 + O16int + softrr.
>
> Softrr ? Which patch? Davide's? Noone has tried to make them compatible 
> (yet?). Even so, this may be unrelated to softrr.

Are there more than one.  I'm using something off xmailserver.org.
Anyhow, no softrr tasks were running at the time.

>> What can I do to collect more information about the problem?
>
> Run top in batch mode as root reniced to -11 so it doesn't get preempted and 
> capture it happening before you kill XEmacs. Then try running XEmacs niced 
> +10 and see if it doesn't happen there. Also if it was lucky enough that you 
> booted with profiling enabled you could profile it, but top will
> tell if it's a simple scheduler starvation error.

I'll do that, it's easily reproducible, at least.

-- 
Måns Rullgård
mru@users.sf.net

