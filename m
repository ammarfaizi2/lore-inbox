Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136108AbREDJeb>; Fri, 4 May 2001 05:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136078AbREDJeV>; Fri, 4 May 2001 05:34:21 -0400
Received: from ems.flashnet.it ([194.247.160.44]:6672 "EHLO relay.flashnet.it")
	by vger.kernel.org with ESMTP id <S136045AbREDJeQ>;
	Fri, 4 May 2001 05:34:16 -0400
Date: Fri, 4 May 2001 09:48:12 +0200
From: David Santinoli <david@santinoli.com>
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx: first mount always fails
Message-ID: <20010504094812.A716@astrid.santinoli.com>
In-Reply-To: <20010413114559.A1133@aidi.santinoli.com> <200104240427.f3O4Ros93448@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200104240427.f3O4Ros93448@aslan.scsiguy.com>; from gibbs@scsiguy.com on Mon, Apr 23, 2001 at 10:27:50PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 10:27:50PM -0600, Justin T. Gibbs wrote:
> My guess is that your CDROM drive takes longer than most to perform
> the initial read capacity.  There is little to be done for this other
> than uping the timeout value in the CD driver.
It was a hardware issue indeed - an upgrade of the drive firmware solved the
problem.

Cheers,
 David
