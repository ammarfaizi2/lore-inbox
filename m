Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWDGSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWDGSYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWDGSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:24:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53696 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964846AbWDGSYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:24:44 -0400
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait4/waitpid/waitid oddness
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 07 Apr 2006 12:23:38 -0600
In-Reply-To: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com> (Albert
 Cahalan's message of "Wed, 5 Apr 2006 23:38:20 -0400")
Message-ID: <m1acaxnt1x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> The kernel prohibits:
>
> 1. WNOHANG on waitpid/wait4

Not 2.6.17-rc1, and not for a lot of earlier kernels.
At least not on ingress, and just skimming the code
I can't see any deeper checks that would prevent this.

> 2. __WALL on waitid
>
> Why? I need both at once.

Which kernel is failing, and how?

Eric
