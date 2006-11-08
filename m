Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754641AbWKHS0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbWKHS0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbWKHS0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:26:25 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:3757 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1754641AbWKHS0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:26:24 -0500
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="87356468:sNHT45043020"
To: Avi Kivity <avi@qumranet.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
X-Message-Flag: Warning: May contain useful information
References: <454E4941.7000108@qumranet.com>
	<20061107204440.090450ea.akpm@osdl.org> <adafycuh77b.fsf@cisco.com>
	<455183EA.2020405@qumranet.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 08 Nov 2006 10:26:22 -0800
In-Reply-To: <455183EA.2020405@qumranet.com> (Avi Kivity's message of "Wed, 08 Nov 2006 09:14:50 +0200")
Message-ID: <adabqnhhk1d.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Nov 2006 18:26:23.0039 (UTC) FILETIME=[64C164F0:01C70363]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Either that or a bunch of ugly .byte macros.

After reading this thread, I have to say that this seems preferable to
relying on new-ish binutils.  Someday in the future we can fix it up
but I think too many people are still using old gas versions now.

You can hide the .byte crap in one place with #defines I think, so
it's not so bad.  We already do this for a few things in asm-i386 and
asm-x86_64 anyway.

 - R.
