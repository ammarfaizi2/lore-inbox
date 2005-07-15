Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVGOKY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVGOKY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVGOKY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:24:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64642 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261585AbVGOKXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:23:55 -0400
Date: Fri, 15 Jul 2005 12:23:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Dave Chinner <dgc@sgi.com>, Nathan Scott <nathans@sgi.com>,
       Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>
Subject: Re: RT and XFS
Message-ID: <20050715102311.GA5302@elte.hu>
References: <1121209293.26644.8.camel@dhcp153.mvista.com> <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu> <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050714002246.GA937@frodo> <20050714135023.E241419@melbourne.sgi.com> <1121314226.14816.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121314226.14816.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> PI is always good, cause it allows the tracking of what is high 
> priority , and what is not .

that's just plain wrong. PI might be good if one cares about priorities 
and worst-case latencies, but most of the time the kernel is plain good 
enough and we dont care. PI can also be pretty expensive. So in no way, 
shape or form can PI be "always good".

	Ingo
