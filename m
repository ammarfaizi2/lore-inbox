Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264922AbSJ3Wfh>; Wed, 30 Oct 2002 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264930AbSJ3Wfh>; Wed, 30 Oct 2002 17:35:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264922AbSJ3Wfg>;
	Wed, 30 Oct 2002 17:35:36 -0500
Subject: Re: [CFT] [PATCH] kexec 2.5.44 (minimal)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>, Pavel Machek <pavel@ucw.cz>,
       "Ph. Marek" <marek@bmlv.gv.at>, Pavel Roskin <proski@gnu.org>,
       Torrey Hoffman <thoffman@arnor.net>,
       Rob Landley <landley@trommello.org>,
       Kasper Dupont <kasperd@daimi.au.dk>
In-Reply-To: <m1lm4jj7v5.fsf_-_@frodo.biederman.org>
References: <m1lm4jj7v5.fsf_-_@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Oct 2002 14:41:54 -0800
Message-Id: <1036017717.1726.7.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 00:16, Eric W. Biederman wrote:
> And is currently kept in two pieces.
> The pure system call.
> http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.44.x86kexec-2.diff
> 
> And the set of hardware fixes known to help kexec.
> http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.44.x86kexec-hwfixes.diff

Eric,

Hmmm... I'm having a lot more problems on my troublesome machine with
this patchset than I did with the previous iteration.  I've
triple-checked the application of the patches, but I can't even get
kexec_test to start, much less run to completion.

The new behavior is that the system appears to hang immediately after
invoking "kexec kexec_test".

What could I have done wrong?

Thanks,
Andy


