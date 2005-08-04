Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVHDHAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVHDHAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVHDHAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:00:40 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:19989 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261905AbVHDG7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:59:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=INEmiWyHb9nm9qiQPtL5r7+nFc2G4zirELG8HMsVNRzSqZWGKe7/lUg5VFufHybcyKSsMwGwFUd/uwQ4TMGllrdogS0ZZ7S1GFQxcrxaE+gfaWcpgQQimPe4HHjKZcVNXcowtjSl+dLva/gTcSBrk+JFGhodggqxunov22Covz4=
Message-ID: <3afbacad05080323596b39e9eb@mail.gmail.com>
Date: Thu, 4 Aug 2005 08:59:32 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
In-Reply-To: <3afbacad0508032234f9af1f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508031559.24704.kernel@kolivas.org>
	 <200508040716.24346.kernel@kolivas.org>
	 <3afbacad050803152226016790@mail.gmail.com>
	 <200508040852.10224.kernel@kolivas.org>
	 <3afbacad0508032234f9af1f3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just borrowed a power meter to see (or not to see) real effects of
dyntick. The difference between static 1000 HZ and dynamic HZ is much
less than I expected, only a very little about noise.  With dyntick
disabled at 1000 HZ my laptop needs 31,3 W.  With dyntick enabled I
get 29.8 W, the pmstats-0.2 script shows me that the system is at
35-45 HZ when it is idle.

The power consumption difference between 250 HZ static and dyntick is
below the noise, so maybe hardly worth all the struggle.

Regards,
Jim
