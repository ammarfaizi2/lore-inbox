Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264391AbUEJHHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUEJHHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 03:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUEJHHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 03:07:36 -0400
Received: from main.gmane.org ([80.91.224.249]:21130 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264391AbUEJHHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 03:07:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Mon, 10 May 2004 09:08:41 +0200
Message-ID: <yw1xsme869om.fsf@kth.se>
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet> <40927417.6040100@nortelnetworks.com>
 <DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com>
 <40927F21.9010703@nortelnetworks.com> <20040510062556.GA1565@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:NfIja9JXUufEJJySxmHtEByzjWo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff <R.E.Wolff@BitWizard.nl> writes:

> On Fri, Apr 30, 2004 at 12:30:25PM -0400, Chris Friesen wrote:
>> Marc Boucher wrote:
>> >
>> >Chris,
>> >
>> >people should, before insulting us publicly or make unsubstantiated 
>> >claims that we "lie" or engage in "illegal" actions, perhaps consult a 
>> >lawyer, and simultaneously use the opportunity to enquire about the 
>> >meaning of "slander".
>> 
>> The C string library considers a null to terminate the string.  You added a 
>> null after the "GPL". It appears to me that this is telling the kernel that 
>> the module is licensed as "GPL", even though it is obvious to a person 
>
> How about the following:
>
> The MODULE_LICENCE macro is a technical way of indicating the licence
> to the kernel. There are various ways of putting "comments and remarks"
> about the licence in the source code, but techically, if 
> 	strcmp (MODULE_LICENCE, "GPL") == 0
> then the module is licenced under GPL.  (*)

What if my module is licensed under the Grand Proprietary License (GPL)?

-- 
Måns Rullgård
mru@kth.se

