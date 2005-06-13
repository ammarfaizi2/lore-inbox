Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVFMXst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFMXst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFMXrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:47:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40356 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261478AbVFMXfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 19:35:18 -0400
Date: Tue, 14 Jun 2005 01:35:13 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Duffy <tduffy@sun.com>
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
Message-ID: <20050613233513.GL21345@wotan.suse.de>
References: <84EA05E2CA77634C82730353CBE3A84301CFC14D@SAUSEXMB1.amd.com> <1118703526.17085.1.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118703526.17085.1.camel@duffman>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 03:58:46PM -0700, Tom Duffy wrote:
> On Mon, 2005-06-13 at 17:44 -0500, Langsdorf, Mark wrote:
> > It looks like it's happening sometime after cpuspeed starts.
> > Could you disable cpuspeed and see if the problem still
> > occurs? 
> 
> Yup, disabling cpuspeed will allow me to get up to multiuser.

That just means the powernow driver is not actually used.

-Andi
