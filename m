Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272323AbTHSREi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272321AbTHSREi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:04:38 -0400
Received: from main.gmane.org ([80.91.224.249]:25300 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272323AbTHSQjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:39:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] O17int
Date: Tue, 19 Aug 2003 18:39:22 +0200
Message-ID: <yw1xn0e5lhz9.fsf@users.sourceforge.net>
References: <200308200102.04155.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:FccMHiDV1aTvkyljwK+RyGc2SZE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Food for the starving masses.
>
> This patch prevents any single task from being able to starve the
> runqueue that it's on. This minimises the impact a poorly behaved
> application or a malicious one has on the rest of the system. If an

I have to disagree.  Open a file of a few hundred lines in XEmacs and
do a regexp search for "^[> ]*-*\n\\([> ]*.*\n\\)*[> ]*foo".  The
system will more or less freeze.  It's a very nasty regexp, and it's
an error to try to use it, but it still shouldn't freeze the system.

-- 
Måns Rullgård
mru@users.sf.net

