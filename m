Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUDARit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUDARis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:38:48 -0500
Received: from holomorphy.com ([207.189.100.168]:41134 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262996AbUDARir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:38:47 -0500
Date: Thu, 1 Apr 2004 09:38:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401173843.GF791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <20040401173417.GO18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401173417.GO18585@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 07:34:17PM +0200, Andrea Arcangeli wrote:
> it's not compiling:
> security/sysctl_capable.c:273: error: redefinition of `capability_sysctl_zero'
> security/sysctl_capable.c:68: error: `capability_sysctl_zero' previously defined here
> security/sysctl_capable.c:274: error: redefinition of `capability_sysctl_one'
> security/sysctl_capable.c:69: error: `capability_sysctl_one' previously defined here
> security/sysctl_capable.c:278: error: redefinition of `capability_sysctl_table'

Hmm, there aren't 270+ lines in the file; it looks like I may have posted
a full replacement instead of an incremental diff.


-- wli
