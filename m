Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271921AbRIDJof>; Tue, 4 Sep 2001 05:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271923AbRIDJo0>; Tue, 4 Sep 2001 05:44:26 -0400
Received: from ns.suse.de ([213.95.15.193]:29454 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271921AbRIDJoR>;
	Tue, 4 Sep 2001 05:44:17 -0400
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
In-Reply-To: <20010902105538.A15344@middle.of.nowhere.suse.lists.linux.kernel> <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <20010902195717.A21209@middle.of.nowhere.suse.lists.linux.kernel> <20010903003437.A385@linux-m68k.org.suse.lists.linux.kernel> <20010903213835.A13887@fury.csh.rit.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Sep 2001 11:44:30 +0200
In-Reply-To: Jeff Mahoney's message of "4 Sep 2001 03:41:51 +0200"
Message-ID: <oupoforxpc1.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> writes:


>     I did kick around the idea of making those macros the default accessors for
>     the deh_state member (which is the only place they're used), but it unfairly
>     penalizes arches that don't need them.

On archs that don't need them {get,put}_unaligned should be just normal
assignments. They are certainly on i386.


-Andi
