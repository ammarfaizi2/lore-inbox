Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUGLU1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUGLU1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUGLU1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:27:41 -0400
Received: from holomorphy.com ([207.189.100.168]:38032 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262547AbUGLUZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:25:29 -0400
Date: Mon, 12 Jul 2004 13:25:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rob Mueller <robm@fastmail.fm>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
Message-ID: <20040712202525.GJ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rob Mueller <robm@fastmail.fm>, Chris Mason <mason@suse.com>,
	linux-kernel@vger.kernel.org
References: <00f601c46539$0bdf47a0$e6afc742@ROBMHP> <1089377936.3956.148.camel@watt.suse.com> <009e01c46849$f2e85430$9aafc742@ROBMHP> <20040712201154.GI21066@holomorphy.com> <00b001c4684c$d060bb20$9aafc742@ROBMHP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b001c4684c$d060bb20$9aafc742@ROBMHP>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was shamelessly removed from:
>> Nice, deep stack there; however, this appears to only be one process. It
>> may be helpful to see the others.

On Mon, Jul 12, 2004 at 01:14:12PM -0700, Rob Mueller wrote:
> I've put the dumps here. I did sysreq-t twice, thus the 2 dumps. If you 
> diff them, you'll see they're very very similar.
> http://robm.fastmail.fm/kernel/t2/

Hmm, I wonder which of the two lock_page()'s in filemap_nopage() this is.


-- wli
