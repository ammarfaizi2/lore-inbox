Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbTCFSiz>; Thu, 6 Mar 2003 13:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268190AbTCFSiz>; Thu, 6 Mar 2003 13:38:55 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:55818 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268149AbTCFSiz>; Thu, 6 Mar 2003 13:38:55 -0500
Date: Thu, 6 Mar 2003 18:49:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Gabriel Paubert <paubert@iram.es>,
       randy.dunlap@verizon.net, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] move SWAP option in menu
Message-ID: <20030306184922.A15683@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Rini <trini@kernel.crashing.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Gabriel Paubert <paubert@iram.es>, randy.dunlap@verizon.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3E657EBD.59E167D6@verizon.net> <20030305181748.GA11729@iram.es> <20030305131444.1b9b0cf2.rddunlap@osdl.org> <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net>; from trini@kernel.crashing.org on Thu, Mar 06, 2003 at 11:43:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 11:43:32AM -0700, Tom Rini wrote:
> How's this look?  I picked MMU=x implies SWAP=x for defaults, just
> because that's how they were before...

CONFIG_SWAP must be n if CONFIG_MMU isn't set either, so it shouldn't
be an option for those targets.

