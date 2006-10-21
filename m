Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992790AbWJURTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992790AbWJURTF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992784AbWJURTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:19:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992790AbWJURTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:19:04 -0400
Date: Sat, 21 Oct 2006 13:18:48 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: jbeulich@novell.com, patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/19] x86: Use -maccumulate-outgoing-args
Message-ID: <20061021171848.GC30758@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	jbeulich@novell.com, patches@x86-64.org,
	linux-kernel@vger.kernel.org
References: <20061021651.356252000@suse.de> <20061021165128.23A8913C4D@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061021165128.23A8913C4D@wotan.suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 06:51:28PM +0200, Andi Kleen wrote:
 > 
 > This avoids some problems with gcc 4.x and earlier generating
 > invalid unwind information. In 4.1 the option is default
 > when unwind information is enabled.
 > 
 > And it seems to generate smaller code too, so it's probably
 > a good thing on its own. With gcc 4.0:

That's quite odd. The gcc man page mentions that 
"The drawback is a notable increase in code size."
for this option.  I wonder if this is just stale documentation,
or there's a reason why we're special :)
 
	Dave

-- 
http://www.codemonkey.org.uk
