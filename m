Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbUCZQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 11:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUCZQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 11:59:18 -0500
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:13378 "EHLO
	rtp-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S264083AbUCZQ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 11:59:15 -0500
X-BrightmailFiltered: true
To: James Morris <jmorris@redhat.com>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <Matt_Domsch@dell.com>
Subject: Re: [PATCH] lib/libcrc32c implementation
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
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
Date: Fri, 26 Mar 2004 10:59:09 -0600
In-Reply-To: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com> (James
 Morris's message of "Fri, 26 Mar 2004 11:36:15 -0500 (EST)")
Message-ID: <yqujzna3tuhu.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004, James Morris verbalised:
> On Mon, 22 Mar 2004, Clay Haapala wrote:
> 
>> This patch agains 2.6.4 kernel code implements the CRC32C
>> algorithm.  The routines are based on the same design as the
>> existing CRC32 code.  Licensing is intended to be identical (GPL).
> 
> These need to be rediffed against the latest Linus kernel.
> 
> It may be better to wait until 2.6.5 comes out, so we don't have too
> much new stuff going into the -rc kernels.
> 
All right, I'll wait for the 2.6.5 announcement and submit a diff
against that.  I assume that the code looks OK.

Thanks!
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
	       "Microsoft bans gnus on these premises."
