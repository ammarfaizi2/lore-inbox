Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRC2VZw>; Thu, 29 Mar 2001 16:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRC2VZm>; Thu, 29 Mar 2001 16:25:42 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:43208 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S129078AbRC2VZf>;
	Thu, 29 Mar 2001 16:25:35 -0500
To: dank@trellisinc.com
Cc: linux-kernel@vger.kernel.org, Eli Carter <eli.carter@inet.com>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <20010329210925.3161C6E099@fancypants.trellisinc.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 29 Mar 2001 13:25:01 -0800
In-Reply-To: dank@trellisinc.com's message of "Thu, 29 Mar 2001 16:09:25 -0500 (EST)"
Message-ID: <m3hf0cs1xu.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dank@trellisinc.com writes:

> with the new ansi standard, this use of __inline__ is no longer
> necessary,

This is not correct.  Since the semantics of inline in C99 and gcc
differ all code which depends on the gcc semantics should continue to
use __inline__ since this keyword will hopefully forever signal the
gcc semantics.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
