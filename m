Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTJQNHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTJQNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:07:32 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:49280 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263462AbTJQNHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:07:31 -0400
From: jlnance@unity.ncsu.edu
Date: Fri, 17 Oct 2003 09:07:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017130729.GB2794@ncsu.edu>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017013245.GA6053@ncsu.edu> <1066355235.3f8f4a2395fa0@horde.sandall.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066355235.3f8f4a2395fa0@horde.sandall.us>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 06:47:15PM -0700, Eric Sandall wrote:

> It doesn't really matter that the hash collision is /less/ likely to ruin data
> than something in hardware as it adds an /extra/ layer of possible corruption,
> so you have a net gain in the possible corruption of your data.  Now, if you
> could write it so that there was /no/ possibility of data corruption, than it
> would be much more acceptable as it wouldn't add any extra likeliness of
> corruption than already exists.

This assumes that the probability of there being a bug in the code which
checks for identical blocks is less than the probability of a hash collision.
I am not sure that is a good assumption.

