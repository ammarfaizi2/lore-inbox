Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTJPT0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJPT0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:26:17 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:60802 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263085AbTJPT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:26:16 -0400
Date: Thu, 16 Oct 2003 20:27:16 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310161927.h9GJRGvm002121@81-2-122-30.bradfords.org.uk>
To: Robert Love <rml@tech9.net>, root@chaos.analogic.com
Cc: John Bradford <john@grabjohn.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, val@nmt.edu
In-Reply-To: <1066330835.5398.74.camel@localhost>
References: <1066163449.4286.4.camel@Borogove>
 <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com>
 <1066330835.5398.74.camel@localhost>
Subject: Re: Transparent compression in the FS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Robert Love <rml@tech9.net>:
> On Thu, 2003-10-16 at 14:56, Richard B. Johnson wrote:
> 
> > No! Not true. 'lossy' means that you can't recover the original
> > data. Some music compression and video compression schemes are
> > lossy. If you can get back the exact input data, it's not lossy.
> 
> ...and with an N-bit hash of M bits of data, where N<M, you cannot
> recover the original data...

I think the confusion has arisen because I said that you can't
compress N values in to <N values.  This is somewhat ambiguous, and
can be taken to mean either:

1. You can't loss-lessly compress N arbitrary values, in to less than
N arbitrary values using a certain mathematical transformation.

or

2. You can't loss-lessly compress all N combinations of M bits, in to
less than M bits, using any mathematical transformation.

Obviously interpretation 1 is incorrect, and interpretation 2 is
correct.

John.
