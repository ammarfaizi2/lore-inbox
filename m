Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUIAPnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUIAPnU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUIAPlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:41:02 -0400
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:22644 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S266887AbUIAPh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:37:57 -0400
X-BrightmailFiltered: true
To: Ryan Breen <ryan.breen@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
References: <20040825163225.4441cfdd.akpm@osdl.org>
	<20040825233739.GP10907@legion.cup.hp.com>
	<20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy>
	<20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy>
	<20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org>
	<20040826163234.GA9047@delft.aura.cs.cmu.edu>
	<Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
	<20040831033950.GA32404@zero>
	<Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
	<413400B6.6040807@pobox.com>
	<d9195cb5040831120178f8b07b@mail.gmail.com>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Wed, 01 Sep 2004 10:37:53 -0500
In-Reply-To: <d9195cb5040831120178f8b07b@mail.gmail.com> (Ryan Breen's message
	of "Tue, 31 Aug 2004 15:01:43 -0400")
Message-ID: <yqujsma26lv2.fsf@chaapala-lnx.cisco.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004, Ryan Breen verbalised:
> On Tue, 31 Aug 2004 00:38:14 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>> 
>> Man, this thread came a long way.
>> 
> 
> You said it -- from Reiser to microkernel.  If we can only figure out
> a way to get a BitKeeper discussion going, we'll have the Grand
> Unified Flamewar.

OK, I'll byte: consider file versioning of an SCM implemented as a
ReiserFS 4 plug-in, as in:

diff -u ultrastore.c/delta/3.2.3 ultrastore.c/delta/3.2.4

(Brrr!  Just had a VMS flash-back shiver.)
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems Storage +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
 The mysterious blob seen in satellite photos off the east coast of Florida
 during the passing of Hurricane Charley has now been positively identified
 as a large cloud of Democrat absentee-ballot applications and voter lists.
