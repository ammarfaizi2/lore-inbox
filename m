Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311915AbSCXKhL>; Sun, 24 Mar 2002 05:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311918AbSCXKhB>; Sun, 24 Mar 2002 05:37:01 -0500
Received: from pD903CA61.dip.t-dialin.net ([217.3.202.97]:50129 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S311915AbSCXKg6>; Sun, 24 Mar 2002 05:36:58 -0500
Date: Sat, 23 Mar 2002 23:09:03 +0100
To: "Little, John" <JOHN.LITTLE@okdhs.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: fork() DoS?
Message-ID: <20020323220903.GA8752@no-maam.dyndns.org>
In-Reply-To: <E7B0663E34409F45B77EFDB62AE0E4D2022360BD@s99mail02.okdhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 09:16:00AM -0600, Little, John wrote:
> I'm really not a programmer, just learning, but was able to bring the system
> to it's knees.  This is a redhat 7.2 kernel.  Is there anyway of preventing
> this?

There are some kernel-patches existing which limit the number of allowed
forks per second. But there is a much shorter way for launching a
forkbomb:

:(){ :|:&};:
