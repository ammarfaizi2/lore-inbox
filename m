Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263374AbTDSKBv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 06:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTDSKBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 06:01:51 -0400
Received: from holomorphy.com ([66.224.33.161]:61324 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263374AbTDSKBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 06:01:50 -0400
Date: Sat, 19 Apr 2003 03:13:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: Re: [CHECKER] 6 memory leaks
Message-ID: <20030419101318.GA8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	irda-users@lists.sourceforge.net
References: <20030419025025.GA32656@Xenon.Stanford.EDU> <20030419094445.GA7283@actcom.co.il> <20030419095526.GE12469@holomorphy.com> <20030419100208.GA7625@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419100208.GA7625@actcom.co.il>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I'm in terror. ASSERT()? return NULL in a macro argument?
>> Any chance of cleaning that up a bit while you're at it?

On Sat, Apr 19, 2003 at 01:02:08PM +0300, Muli Ben-Yehuda wrote:
> I'm afraid it's rather wide-spread... 
> mulix@granada:~/kernel/cvs/linux-2.5$ grep ASSERT net/irda/*.c | grep return | wc -l
>     511
> I'm willing to do the grunt work of converting it, if it's ok with the
> IRDA maintainers. 

I'm not going to ask too much here. Whatever you have time to do, feel
like doing, and can get past the maintainers is fine by me.


-- wli
