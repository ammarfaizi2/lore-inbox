Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUCKThO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUCKThO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:37:14 -0500
Received: from main.gmane.org ([80.91.224.249]:16526 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261668AbUCKTbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:31:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: LKM rootkits in 2.6.x
Date: Thu, 11 Mar 2004 20:31:49 +0100
Message-ID: <yw1xekrz41ui.fsf@kth.se>
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk> <20040311184835.GA21330@redhat.com>
 <1079032587.7517.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-2480.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:nD7yt6PuxonjaHrPjRGNwNlMEbQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> writes:

> Am Do, den 11.03.2004 schrieb Dave Jones um 19:48:
>
>> Don't bet on it.  They'll just start doing what binary-only driver vendors
>> have been doing for months.. If the table isn't exported, they find a symbol
>> that is exported, and grovel around in memory near there until they find
>> something that looks like it, and patch accordingly.
>
> Ugh... this sounds ugly. This should be forbidden. I mean, what are
> things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
> whatever they want?

Who is to stop them?  When running in kernel mode you are god.

-- 
Måns Rullgård
mru@kth.se

