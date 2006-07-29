Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWG2R6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWG2R6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWG2R6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:58:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:48470 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932198AbWG2R6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:58:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=T7cesYqpTVDcXzPf3X9q+Ddi5bd9kUmuMLeUWSxTHUU/BwvF5BRqrUtDJ0F1Wsb5RkmaCCjK0IflbJH9Tyn1V+6UYyaArl3L6mFLjB5/0j9+3Eo80lNniM3Lyw1mpnLAf6hmSRw0t76ZssAJJdj+FWXvUzbYLjtBRPAsfdjK3Cw=
Message-ID: <44CBA1AD.4060602@gmail.com>
Date: Sat, 29 Jul 2006 19:57:42 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-mm@kvack.org
Subject: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
References: <20060727015639.9c89db57.akpm@osdl.org>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton napsal(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/

Hello,

I have problems with swsusp again. While suspending, the very last thing kernel
writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
Here is a snapshot of the screen:
http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif

It's SMP system (HT), higmem enabled (1 gig of ram).

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
