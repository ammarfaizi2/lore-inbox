Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTDFJOi (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 05:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTDFJOi (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 05:14:38 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:13817 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S262882AbTDFJOh (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 05:14:37 -0400
Date: Sun, 6 Apr 2003 05:26:03 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       andrea@suse.de, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406052603.A4440@redhat.com>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405232524.GD1828@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030405232524.GD1828@holomorphy.com>; from wli@holomorphy.com on Sat, Apr 05, 2003 at 03:25:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 03:25:24PM -0800, William Lee Irwin III wrote:
> I apparently erred when I claimed this kind of test would not provide
> useful figures of merit for page replacement algorithms. There appears
> to be more to life than picking the right pages.

This is precisely the conclusion which davem and myself came to, and 
explained at the beginning of this whole ordeal.  It all boils down to 
the complexity of the algorithm, and the fact that the number of cache 
misses scales with that.

Can we get on with merging pgcl to mitigate some of the rmap costs now?  ;-)

		-ben
