Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVDAQOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVDAQOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVDAQOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:14:50 -0500
Received: from main.gmane.org ([80.91.229.2]:10460 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262778AbVDAQOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:14:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [RFD] 'nice' attribute for executable files
Date: Fri, 01 Apr 2005 18:12:21 +0200
Message-ID: <yw1xy8c2pjbu.fsf@ford.inprovide.com>
References: <200503311556.j2VFu9Hc007903@laptop11.inf.utfsm.cl> <424D6B54.2090200@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:LmX7ziEqd/IIPWkCGhjdAlBoK/U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor <victorjan@poczta.onet.pl> writes:

> Horst von Brand wrote:
>> Even better: Write a C wrapper for each affected program that just
>> renices
>> it as needed.
>
> I suggest to implement scalable solution, so the final user wont't
> have to write separate wrapper for *each* program. universal wrapper
> is better solution, but (now i know, that implementing something that
> can be dangerous if used incorrectly is so evil, that only the devil
> could have proposed it) it forces use of database (that normally would
> be kept in filesystem's file metadata)

A userspace solution could still use POSIX extended attributes.

> and if some-malicious-person would have accessed it in write mode
> (as result of wrong file permissions), the system performerance
> would be in danger. in my solution, there is per-file attribute,
> accessible only for root, and if hacker has root permissions,
> existence of nice attribute is meaningless.

You forgot something: this idea of yours needs to be implemented,
tested, and debugged.  Those things take time, and effort, and are
still of very little value.

-- 
Måns Rullgård
mru@inprovide.com

