Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVCaQF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVCaQF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVCaQF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:05:59 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:199 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261523AbVCaQFy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:05:54 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <200503311556.j2VFu9Hc007903@laptop11.inf.utfsm.cl>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Thu, 31 Mar 2005 18:05:50 +0200
In-Reply-To: <200503311556.j2VFu9Hc007903@laptop11.inf.utfsm.cl> (Horst von
 Brand's message of "Thu, 31 Mar 2005 11:56:09 -0400")
Message-ID: <yw1xwtrnu7fl.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com> said:
>> Wiktor <victorjan@poczta.onet.pl> writes:
>
> [...]
>
>> > max renice ulimit is quite good idea, but it allows to change nice of
>> > *any* process user has permissions to. it could be implemented also,
>> > but the idea of 'nice' file attribute is to allow *only* some process
>> > be run with lower nice. what's more, that nice would be *always* the
>> > same (at process startup)!
>
>> It can be done entirely in userspace, if you want it.  Just hack your
>> shell to examine some extended attribute of your choice, and adjust
>> the nice value before executing files.  Then arrange to have the shell
>> run with a negative nice value.  This can be easily accomplished with
>> a simple wrapper, only for the shell.
>
> Even better: Write a C wrapper for each affected program that just renices
> it as needed.

The OP was too lazy to do this.

-- 
Måns Rullgård
mru@inprovide.com
