Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135281AbRDLTnE>; Thu, 12 Apr 2001 15:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135278AbRDLTmU>; Thu, 12 Apr 2001 15:42:20 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:12241 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135271AbRDLTkU>;
	Thu, 12 Apr 2001 15:40:20 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
In-Reply-To: <200104121929.MAA04049@adam.yggdrasil.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 12 Apr 2001 12:40:20 -0700
In-Reply-To: "Adam J. Richter"'s message of "Thu, 12 Apr 2001 12:29:33 -0700"
Message-ID: <m33dbdsy8r.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> 	I am aware of a couple of cases where code relied on static
> variables being allocated contiguously, but, in both cases, those
> variables were either all zeros or all non-zeros, so my proposed
> change would not break such code.

Continuous placement is not the only property defined by
initialization.  There are many more.  You cannot change this since it
will quite a few programs and libraries and subtle and hard to
impossible to identify ways.  Simply educate programmers to not
initialize.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
