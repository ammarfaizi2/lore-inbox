Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWB0UN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWB0UN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWB0UN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:13:28 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:46351 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932338AbWB0UN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:13:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=cNiOAfdC6jM+5RAXWwYI1pwfQ3u9M4BqVeZWTYySEkclEhHeswAGV7E7trT+0txD1A5PIIhN5993bYmGR08iCNm/or1HgmVsgEeyrVRR1UHFqG5R0lfJDCZ3jH0krz1G192LEpfg9ayoR/b+pFHaOc5HHDWvEqNOcR1ZwNRJ9g8=
Date: Mon, 27 Feb 2006 21:13:15 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, davej@redhat.com, perex@suse.cz, kay.sievers@vrfy.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-Id: <20060227211315.e7a04524.diegocg@gmail.com>
In-Reply-To: <20060227200041.GA11400@suse.de>
References: <20060227190150.GA9121@kroah.com>
	<20060227203520.0df1d548.diegocg@gmail.com>
	<20060227194941.GD9991@suse.de>
	<20060227205759.4a7c7c13.diegocg@gmail.com>
	<20060227200041.GA11400@suse.de>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 27 Feb 2006 12:00:41 -0800,
Greg KH <gregkh@suse.de> escribió:

> No, look at the different descriptions that I gave them in the README
> please.  They are very different.  If you think the wording there is not
> precise enough, could you suggest some other wording?


Maybe "Developers should not release stable versions of userspace
applications which depend on "unstable" interfaces, they're only
good for development versions, if you need to use a "unstable"
interface for your program you should wait at least until it hits
"testing" (or even better, "stable")"; or something like that.
