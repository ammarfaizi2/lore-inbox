Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVDOS0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVDOS0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVDOSYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:24:30 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:31938 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S261910AbVDOSXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:23:44 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Fri, 15 Apr 2005 20:23:26 +0200
In-Reply-To: <87wtr8rdvu.fsf@blackdown.de> (Juergen Kreileder's message of
	"Tue, 12 Apr 2005 03:18:45 +0200")
Message-ID: <87u0m7aogx.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Kreileder <jk@blackdown.de> writes:

> Andrew Morton <akpm@osdl.org> writes:
>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
>
> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.

I think I finally found the culprit.  Both rc2-mm3 and rc1-mm1 work
fine when I reverse the timer-* patches.

Any idea?  Bug in my ppc64 gcc?


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
