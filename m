Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293579AbSCFVbq>; Wed, 6 Mar 2002 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310202AbSCFVbh>; Wed, 6 Mar 2002 16:31:37 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:45549 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S293579AbSCFVbW>; Wed, 6 Mar 2002 16:31:22 -0500
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <Pine.LNX.4.33.0203061238380.17114-100000@twinlark.arctic.org>
From: Chris Ball <chris@void.printf.net>
Date: 06 Mar 2002 21:31:10 +0000
In-Reply-To: <Pine.LNX.4.33.0203061238380.17114-100000@twinlark.arctic.org>
Message-ID: <87bse14c4h.fsf@lexis.house.pkl.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "dean" == dean gaudet <dean-list-linux-kernel@arctic.org> writes:

    dean> ingo started the proper work for this, for example, see:
    dean> <http://people.redhat.com/mingo/vsyscall-patches/vsyscall-2.3.32-F4>
    dean> (there's a documentation file near the bottom of the patch)
    dean> but it doesn't appear to support gettimeofday via rdtsc yet.

Interesting patch; when last I looked, vsyscalls were only being
implemented on the new 64-bit architectures.

Does this patch break binary compatibility?  I seem to recall that being
Andrea's reason for not running vsyscalls on standard x86 back in August
last year.

- Chris.
-- 
$a="printf.net"; Chris Ball | chris@void.$a | www.$a | finger: chris@$a
         "In the beginning there was nothing, which exploded."

