Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbTHTSpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTHTSpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:45:51 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28689
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262137AbTHTSpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:45:50 -0400
Date: Wed, 20 Aug 2003 11:45:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Message-ID: <20030820184546.GA1040@matchmail.com>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	Eric St-Laurent <ericstl34@sympatico.ca>,
	linux-kernel@vger.kernel.org
References: <1061261666.2094.15.camel@orbiter> <3F419449.4070104@cyberone.com.au> <20030819175105.GA19465@matchmail.com> <3F42DFEB.9010404@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F42DFEB.9010404@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 12:41:47PM +1000, Nick Piggin wrote:
> My idea is just to modify timeslices. It should achieve a similar
> effect to what you describe I think.

And how do you have one time slice per array switch (what's the term for
that?) and larger slices for lower nice levels, how does that work?
