Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTJWCwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 22:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTJWCwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 22:52:31 -0400
Received: from holomorphy.com ([66.224.33.161]:18839 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261606AbTJWCwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 22:52:30 -0400
Date: Wed, 22 Oct 2003 19:52:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031023025210.GB14431@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Joseph D. Wagner" <theman@josephdwagner.info>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <200310221855.15925.theman@josephdwagner.info> <200310221947.45996.theman@josephdwagner.info> <20031023012350.GI26476@redhat.com> <200310222135.22968.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310222135.22968.theman@josephdwagner.info>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, davej wrote:
>> You can't use FP code in the kernel.

On Wed, Oct 22, 2003 at 09:35:22PM +0600, Joseph D. Wagner wrote:
> What can't be done today, might be done tommorrow.
> I've long complained -- in this forum and in others -- that there's a lack 
> of vision, or at least a lack of documented and published vision, when it 
> comes to the future of kernel development.  If you're wondering why I don't 
> do it myself, it's because I don't know enough of where the project is 
> headed, and I can't find out because it's not documented.  Catch-22.  
> However, this is entirely a separate discussion.
> I am thinking of future development.  I know this point is kind of moot 
> because 2.6 already adopts the change, but that hasn't stopped about a 
> dozen backports of other features to previous versions of the kernel.

Please read up on how kernels handle saving and restoring user floating
point contexts before spraying out anything more of this kind on the list
(preferably never doing so again regardless).


-- wli
