Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbTDOILO (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTDOILO (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:11:14 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:2433
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264406AbTDOILN (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:11:13 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem and solution: 2.5 broke KDE panel (kpanel)
References: <200304150403_MC3-1-3478-63FB@compuserve.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 10:17:31 +0200
In-Reply-To: <200304150403_MC3-1-3478-63FB@compuserve.com>
Message-ID: <yw1xbrz89ntw.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

>  When I tried KDE 3.0 on kernel 2.5.66 I got an exception message
> from kpanel.  Everything else worked OK but there was no panel, so
> it wasn't much fun.
> 
>  Solution: boot up 2.4 and remove applets from the panel.  The system
> monitor seems to be the problem -- it faulted when I tried to add it
> back (but the panel kept running.)

This is probably caused by some file in /proc changing format.  The
memory monitor in gnome is also broken

-- 
Måns Rullgård
mru@users.sf.net
