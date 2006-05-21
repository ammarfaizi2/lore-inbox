Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWEUIrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWEUIrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEUIrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:47:31 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:49851 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751510AbWEUIrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:47:31 -0400
Date: Sun, 21 May 2006 01:47:28 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Haar J?nos <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
Message-ID: <20060521084728.GA2535@taniwha.stupidest.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010801c67cb1$bc13fd00$1800a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 10:37:00AM +0200, Haar J?nos wrote:

>              total       used       free     shared    buffers     cached
> Mem:       2073048     893360    1179688          0     829092      19820
> Low:        893464     868352      25112          0          0          0
> High:      1179584      25008    1154576          0          0          0
> -/+ buffers/cache:      44448    2028600
> Swap:            0          0          0

looks bad for lowmem

what does /proc/meminfo say?

what about the output from "slabtop -sc" ?

