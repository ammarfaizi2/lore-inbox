Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUHEIXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUHEIXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267593AbUHEIXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:23:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267589AbUHEIXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:23:03 -0400
Message-ID: <4111EE31.1090105@redhat.com>
Date: Thu, 05 Aug 2004 01:22:09 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: inaky.perez-gonzalez@intel.com, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org, rusty@rustcorp.com.au, mingo@elte.hu,
       jamie@shareable.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>	<20040804232123.3906dab6.akpm@osdl.org>	<4111DC8C.7050504@redhat.com>	<20040805001737.78afb0d6.akpm@osdl.org>	<4111E3B5.1070608@redhat.com> <20040805004023.65463e88.akpm@osdl.org>
In-Reply-To: <20040805004023.65463e88.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> But doesn't the current futex code continue to work unchanged?

If the patches don't touch the existing futex code there is no risk of
breaking anything.  Futexes and these new objects have nothing to do
with each other.


> I was referring to "scheduling-policy based unlock/wakeup", actually.

We don't have anything like this for futexes.  It's not impossible to
do, we just didn't do it because it was of not much interest to us at
that time.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
