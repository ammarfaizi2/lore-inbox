Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWAIP0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWAIP0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWAIP0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:26:48 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:43318 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751045AbWAIP0r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:26:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cUNNgiZ+lfqNv75h5P79sZiWyXLH1Qwxv6oZxdGUDOs2VeIy6FbBh9zf7yTwpy0PwzIZl43qaJQLzTijL39e8bC7HWL1oJLwZLMdgb7SeYZceANGoWn0nmvgx232crUA08ADUJ6wS+PxjBiG7m6rlvNm/PeW+Ps0d9GnUcPskiA=
Message-ID: <728201270601090726i256cf19bj48be55621b86931f@mail.gmail.com>
Date: Mon, 9 Jan 2006 09:26:36 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Back to the Future ? or some thing sinister ?
Cc: Chaitanya Hazarey <cvh.tcs@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060109040322.GA2683@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <eaef64fc0601081131i17336398l304038c6dea3e057@mail.gmail.com>
	 <20060109040322.GA2683@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/06, Nathan Lynch <ntl@pobox.com> wrote:
> Chaitanya Hazarey wrote:
> >
> > We have got a machine, lets say X , make is IBM and the CPU is Intel
> > Pentium 4 2.60 GHz. Its running a 2.6.13.1 Kernel and previously,


Is this machine's time is synchronized with some server using ntp. I
had seen some very similar issue when the clock deviation was more
than a second .If clock is adjusted and time difference becomes more
than 2 sec the diffence becomes negative because timeval has its
members as signed int.It think that issue might be playing a role
here.

Ram
