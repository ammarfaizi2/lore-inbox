Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUEZT10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUEZT10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 15:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265779AbUEZT10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 15:27:26 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:15533 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265777AbUEZT1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 15:27:25 -0400
Date: Wed, 26 May 2004 20:25:29 +0100
From: Dave Jones <davej@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: "David S. Miller" <davem@redhat.com>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, mingo@elte.hu, andrea@suse.de,
       riel@redhat.com, torvalds@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526192529.GA15278@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Mackall <mpm@selenic.com>,
	"David S. Miller" <davem@redhat.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>, mingo@elte.hu,
	andrea@suse.de, riel@redhat.com, torvalds@osdl.org,
	arjanv@redhat.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526111222.4159a771.davem@redhat.com> <20040526190216.GA5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526190216.GA5414@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 02:02:22PM -0500, Matt Mackall wrote:

 > There was a patch floating around for this in the 2.2 era that I
 > ported to 2.4 on one occassion. It won't tell you worst case though,
 > just worst observed case.
 > 
 > Sparse is probably not a bad place to put a real call chain stack analysis.

That won't measure any dynamic stack allocations that we're doing
at runtime, nor will it test all n combinations of drivers, which
is where most of the stack horrors have been found in recent times.

		Dave

