Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272748AbTHENI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272745AbTHENI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:08:57 -0400
Received: from main.gmane.org ([80.91.224.249]:52626 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272752AbTHENI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:08:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Will kernel compiled for PentiumII run on IBM 6x86MX?
Date: Tue, 05 Aug 2003 14:48:51 +0200
Message-ID: <yw1xoez42rt8.fsf@users.sourceforge.net>
References: <3F2FA47B.3040007@asfandyar.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:U2EQzfiOYOi6wuBidSSR2mPrkS4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asfand Yar Qazi <email@asfandyar.cjb.net> writes:

> Read somewhere that the 6x86MX is PentiumII code compatible, but these
> processors are listed as two separate options under the kernel config
> (2.4.21)
>
> Will a kernel/apps compiled for PII run on a 6x86MX?

I don't know the details in this particular case.  However, even if
two CPUs are object code compatible, it doesn't mean that instruction
scheduling, caching and such things behave the same way.  Code
optimized for one CPU might not be optimal for another, even if it
runs.

-- 
Måns Rullgård
mru@users.sf.net

