Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267959AbTGIAD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267966AbTGIAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:03:27 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51468
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S267959AbTGIAD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:03:26 -0400
Date: Tue, 8 Jul 2003 17:18:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ram?n Rey Vicente???? <retes_simbad@yahoo.es>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm2 [kernel BUG at include/linux/list.h:148!]
Message-ID: <20030709001803.GC16488@matchmail.com>
Mail-Followup-To: Ram?n Rey Vicente???? <retes_simbad@yahoo.es>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20030705132528.542ac65e.akpm@osdl.org> <1057455650.3119.3.camel@debian> <20030706134926.GA472@nikolas.hn.org> <20030708004350.GA16488@matchmail.com> <1057706251.922.1.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057706251.922.1.camel@debian>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 01:17:32AM +0200, Ram?n Rey Vicente???? wrote:
> Call Trace: [<c0116ea0>]  [<c013bb2e>]  [<c013f522>]  [<c011894e>] 
> [<c011c44d>]
>   [<c0109a20>]  [<c01097d3>]  [<c0109ab1>]  [<c0118599>]  [<c0130259>] 
> [<c01621
> 8e>]  [<c01307f8>]  [<c01091ad>]  [<c0118599>]  [<c0193e05>] 
> [<c0116f20>]  [<c0
> 116f20>]  [<c0156924>]  [<c0156dae>]  [<c0157a2a>]  [<c014892c>] 
> [<c0148db9>]  
> [<c0108f47>] 

Now run it through ksymoops.  You should consider using the in kernel oops
decoding.  Just turn kksymoops on in the debugging menu.
