Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUDARmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUDARmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:42:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22404
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263001AbUDARmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:42:43 -0500
Date: Thu, 1 Apr 2004 19:42:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401174242.GR18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <20040401173417.GO18585@dualathlon.random> <20040401173843.GF791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401173843.GF791@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 09:38:43AM -0800, William Lee Irwin III wrote:
> On Thu, Apr 01, 2004 at 07:34:17PM +0200, Andrea Arcangeli wrote:
> > it's not compiling:
> > security/sysctl_capable.c:273: error: redefinition of `capability_sysctl_zero'
> > security/sysctl_capable.c:68: error: `capability_sysctl_zero' previously defined here
> > security/sysctl_capable.c:274: error: redefinition of `capability_sysctl_one'
> > security/sysctl_capable.c:69: error: `capability_sysctl_one' previously defined here
> > security/sysctl_capable.c:278: error: redefinition of `capability_sysctl_table'
> 
> Hmm, there aren't 270+ lines in the file; it looks like I may have posted
> a full replacement instead of an incremental diff.

patch silenty screwed while applying it (I did -R and then reapplied
twice).  Patch should bomb on stuff like that, anyways. I'll try again
now.
