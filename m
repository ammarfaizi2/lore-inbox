Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135265AbRDLTPm>; Thu, 12 Apr 2001 15:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbRDLTPW>; Thu, 12 Apr 2001 15:15:22 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:30672 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135265AbRDLTPL>;
	Thu, 12 Apr 2001 15:15:11 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: johan.adolfsson@axis.com, linux-kernel@vger.kernel.org
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
In-Reply-To: <200104121901.MAA04011@adam.yggdrasil.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 12 Apr 2001 12:14:56 -0700
In-Reply-To: "Adam J. Richter"'s message of "Thu, 12 Apr 2001 12:01:55 -0700"
Message-ID: <m38zl6rkun.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> >Shouldn't a compiler be able to deal with this instead?
> 
> 	Yes.

No.  gcc must not do this.  There are situations where you must place
a zero-initialized variable in .data.  It is a programmer problem.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
