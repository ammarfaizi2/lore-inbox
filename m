Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVBWAlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVBWAlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 19:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVBWAlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 19:41:47 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:61924 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261366AbVBWAlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 19:41:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=H/JvfLfk2S8CyT0c/jbcJn0IUNRkLU65SJ16fw6UCa7bDXFKhmXspmk+baeQr33sBzyYYqw4Ym3F2wMNgXbsxtO7Y1CyJhs+w9aFvbOyGOs/YGMjvs1JGbauK+gUMraXp+udZBJryqz2FBiG6+5eWGEA4pJRqH293rc01s+kYuo=
Message-ID: <876ef97a050222164140968e15@mail.gmail.com>
Date: Tue, 22 Feb 2005 19:41:41 -0500
From: Tobias DiPasquale <codeslinger@gmail.com>
Reply-To: Tobias DiPasquale <codeslinger@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] TCP-Hybla proposal
Cc: John Heffner <jheffner@psc.edu>, shemminger@osdl.org,
       mlists@danielinux.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ccaini@deis.unibo.it,
       rfirrincieli@arces.unibo.it
In-Reply-To: <20050222101447.68a02c12.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502221534.42948.mlists@danielinux.net>
	 <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
	 <Pine.LNX.4.58.0502221247130.22393@dexter.psc.edu>
	 <20050222101447.68a02c12.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 10:14:47 -0800, David S. Miller <davem@davemloft.net> wrote:
> On Tue, 22 Feb 2005 13:03:11 -0500 (EST)
> John Heffner <jheffner@psc.edu> wrote:
> 
> > An idea I've been toying with for a while now is completely abstracting
> > congestion control.  Then you could have congestion control loadable
> > modules, which would avoid this mess of experimental algorithms inside the
> > main-line kernel.  If done right, they might be able to work seamlessly
> > with SCTP, too.  The tricky part is making sure the interface is complete
> > enough.
> 
> The symbols exported to allow this would need to be EXPORT_SYMBOL_GPL().

Why's that?

-- 
[ Tobias DiPasquale ]
0x636f6465736c696e67657240676d61696c2e636f6d
