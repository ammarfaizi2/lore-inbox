Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbRGPSBH>; Mon, 16 Jul 2001 14:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbRGPSA5>; Mon, 16 Jul 2001 14:00:57 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:36343 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S267466AbRGPSAq>;
	Mon, 16 Jul 2001 14:00:46 -0400
To: VGER kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: /proc/sys/kernel/hz
In-Reply-To: <938F7F15145BD311AECE00508B7152DB034C48DA@vts007.vertis.nl>
	<m38zhorf6s.fsf@otr.mynet> <20010716191353.G16948@pckurt.casa-etp.nl>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 16 Jul 2001 10:45:48 -0700
In-Reply-To: Kurt Garloff's message of "Mon, 16 Jul 2001 19:13:53 +0200"
Message-ID: <m34rscrcmr.fsf@otr.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> writes:

> Suppose HZ is variable. How does glibc find out about HZ of the _running_
> kernel? Just curious ... as I don't see a public place where the kernel
> publishes such info.

You people don't even know your kernel:

  $ LD_SHOW_AUXV=1 getconf CLK_TCK

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
