Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbTETQuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTETQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:50:39 -0400
Received: from holomorphy.com ([66.224.33.161]:65152 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263825AbTETQui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:50:38 -0400
Date: Tue, 20 May 2003 10:03:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, kaos@ocs.com.au,
       James.Bottomley@steeleye.com, mort@wildopensource.com,
       davidm@napali.hpl.hp.com, jun.nakajima@intel.com, tomita@cinet.co.jp
Subject: cpu-2.5.69-bk14-1
Message-ID: <20030520170331.GK29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	kaos@ocs.com.au, James.Bottomley@steeleye.com,
	mort@wildopensource.com, davidm@napali.hpl.hp.com,
	jun.nakajima@intel.com, tomita@cinet.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extended cpumasks for larger systems. Now featuring bigsmp, Summit,
and Voyager updates in addition to PC-compatible, NUMA-Q, and SN2
bits from SGI.

Several minor bugfixes with improper checks of bits and some new
API pieces: cpumask_of_cpu() and cpus_promote() for replacing
1 << cpu and promoting "narrow" cpumasks (i.e. unsigned long) to
full-width, respectively.

Successfully runs on 32x NUMA-Q. Successfully compiletested on Voyager,
Summit, bigsmp, and flat logical SMP, all with typechecking. UP also
successfully compiletested with and without local APIC and IO-APIC.
Hopefully I can get my hands on another NUMA-Q quad or two soon.

vs. 2.5.69-bk14. The patch (too large to post) can be found at
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/cpu/cpu-2.5.69-bk14-1.bz2

I'd be much obliged if (sub)arch maintainers could comment.

Tomita, I didn't have a way of building PC98; if you are negatively
affected somehow I'm interested in hearing of how to fix things up
or any other special handling PC98 might need here.

David & Martin, I'm not 100% sure wrt. what's going on with the IA64
pieces of the puzzle. The more I find out about what you want, the
better.

Thanks.


-- wli
