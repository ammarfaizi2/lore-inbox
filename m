Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRIFTx1>; Thu, 6 Sep 2001 15:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272536AbRIFTxM>; Thu, 6 Sep 2001 15:53:12 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30963
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272535AbRIFTw4>; Thu, 6 Sep 2001 15:52:56 -0400
Date: Thu, 6 Sep 2001 12:53:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010906125309.K29607@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0109061623150.8103-100000@duckman.distro.conectiva> <20010906193836Z16130-26183+40@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010906193836Z16130-26183+40@humbolt.nl.linux.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 09:45:35PM +0200, Daniel Phillips wrote:
> What we should be worrying about is how to balance reads against writes under 
> heavy load.
> 

Yes, I agree.  You can have a process that is at a 19 niceness level that
doesn't do much processing, but a lot of disk access bring your system down
to a crawl.

Improvement in this area would be nice.
