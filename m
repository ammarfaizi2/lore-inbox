Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271446AbTGQMBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271442AbTGQMBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:01:50 -0400
Received: from main.gmane.org ([80.91.224.249]:16516 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271441AbTGQL6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:58:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ALSA timer and 2.6.0-test1 panic
Date: Thu, 17 Jul 2003 14:06:04 +0200
Message-ID: <yw1xisq14atv.fsf@users.sourceforge.net>
References: <yw1xlluyln01.fsf@users.sourceforge.net> <s5hlluxzccx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:4nmU6c39nZRE/aT4W7+KhF1q288=
Cc: alsa-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

>> I get thousands of these messages when using the ALSA timer in kernel
>> 2.6.0-test1:
>
> there is an unblanced spinlock.
> could you try the attached patch?

It seems to work.  Thanks.

-- 
Måns Rullgård
mru@users.sf.net

