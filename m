Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTA1HKY>; Tue, 28 Jan 2003 02:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTA1HKY>; Tue, 28 Jan 2003 02:10:24 -0500
Received: from holomorphy.com ([66.224.33.161]:29352 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264875AbTA1HKY>;
	Tue, 28 Jan 2003 02:10:24 -0500
Date: Mon, 27 Jan 2003 23:18:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: kexec reboot code buffer
Message-ID: <20030128071826.GI780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org> <3E35AAE4.10204@us.ibm.com> <m1r8ax69ho.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r8ax69ho.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 12:04:19AM -0700, Eric W. Biederman wrote:
> I agree that lowmem for the common case is fine.  For kexec on panic,
> and a some weird cases using high mem is beneficial.  I don't have
> a problem with changing it back to just lowmem for the time being.

Well, there is the bit about dropping the PAE bit from %cr4 too.
Seriously, just plop down the fresh zone type and all will be well.
It's really incredibly easy.


-- wli
