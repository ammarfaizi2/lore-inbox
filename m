Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265363AbTLHJ45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbTLHJ45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:56:57 -0500
Received: from holomorphy.com ([199.26.172.102]:52698 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265363AbTLHJ44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:56:56 -0500
Date: Mon, 8 Dec 2003 01:56:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Misha Nasledov <misha@nasledov.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 Oops
Message-ID: <20031208095654.GS19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Misha Nasledov <misha@nasledov.com>, linux-kernel@vger.kernel.org
References: <20031208032127.GA14638@nasledov.com> <20031208094138.GE8039@holomorphy.com> <20031208095349.GA1232@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208095349.GA1232@nasledov.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 01:41:38AM -0800, William Lee Irwin III wrote:
>> What did it say the cause for it was? BUG()? Fault?

On Mon, Dec 08, 2003 at 01:53:49AM -0800, Misha Nasledov wrote:
> I don't know; I copied everything off the screen once it stopped scrolling by
> so fast. A few other stack traces popped up but were scrolled up too quickly.
> I couldn't scroll up or anything..

Scheduling while atomic warnings look different and there aren't many
obvious places to oops or BUG in the scheduler (or at least AFAICT there
haven't been stability issues there for some time).


-- wli
