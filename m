Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTKZCBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTKZCBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:01:11 -0500
Received: from holomorphy.com ([199.26.172.102]:27324 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263893AbTKZCBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:01:09 -0500
Date: Tue, 25 Nov 2003 18:01:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc5
Message-ID: <20031126020103.GD8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20031125190442.GB1357@mis-mike-wstn.matchmail.com> <Pine.LNX.4.44.0311251802400.6489-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311251802400.6489-100000@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Mike Fedyk wrote:
>> Will 2.4.23 have the oom killer?

On Tue, Nov 25, 2003 at 06:06:31PM -0200, Marcelo Tosatti wrote:
> No. Andrea removed the oom killer because it had problems (deadlocks, it
> can "guess" wrong in some cases).
> It seems that in most cases killing the allocator (what 2.4.23 does)  
> works fine.
> Having it configurable might be desired. 

Some of the bad behavior was due to races that disturbed the heuristics.
2.6 got those fixed and it made a large difference wrt. correcting its
bad behaviors. It's not infallible, but relatively well-behaved. (Not
that I could be arsed to debate whether that makes it worth keeping.)


-- wli
