Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132045AbRDTVpy>; Fri, 20 Apr 2001 17:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRDTVpe>; Fri, 20 Apr 2001 17:45:34 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:35507 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S132039AbRDTVpc>;
	Fri, 20 Apr 2001 17:45:32 -0400
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <Pine.LNX.3.95.1010420153006.12968A-100000@chaos.analogic.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 20 Apr 2001 14:44:41 -0700
In-Reply-To: "Richard B. Johnson"'s message of "Fri, 20 Apr 2001 15:37:07 -0400 (EDT)"
Message-ID: <m33db3s0ty.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> The kernel doesn't know if a process is going to use the FPU when
> a new process is created. Only the user's code, i.e., the 'C' runtime
> library knows.

Maybe you should try to understand the kernel code and the features of
the processor first.  The kernel can detect when the FPU is used for
the first time.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
