Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268704AbTBZKU4>; Wed, 26 Feb 2003 05:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268706AbTBZKU4>; Wed, 26 Feb 2003 05:20:56 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:40128 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268704AbTBZKUz>; Wed, 26 Feb 2003 05:20:55 -0500
Date: Wed, 26 Feb 2003 10:28:43 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: schlicht@uni-mannheim.de, torvalds@transmeta.com, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-ID: <20030226112843.GA32728@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, schlicht@uni-mannheim.de,
	torvalds@transmeta.com, hugh@veritas.com,
	linux-kernel@vger.kernel.org
References: <200302251908.55097.schlicht@uni-mannheim.de> <20030226103742.GA29250@suse.de> <20030226015409.78e8e1fb.akpm@digeo.com> <20030226111905.GA32415@suse.de> <20030226022819.44e1873a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226022819.44e1873a.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 02:28:19AM -0800, Andrew Morton wrote:

 > > btw, (unrelated) shouldn't smp_call_function be doing magick checks
 > > with cpu_online() ?
 > Looks OK?  It sprays the IPI out to all the other CPUs in cpu_online_map,
 > and waits for num_online_cpus()-1 CPUs to answer.

Doh, of course.
Ugh, mornings.

		Dave

