Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbUKQWMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbUKQWMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUKQWJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:09:28 -0500
Received: from mproxy.gmail.com ([216.239.56.240]:38549 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262636AbUKQWI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:08:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LPGun/IcOgBPsrMvgdTfPCRiZx8e7Czl5V8EY/88n8F6PQQ11BOJ240K/PNRk8iFGQAMW4RssIBWl/ii0F9RLHaOHeVfqY0eutgnqua/SW34beuvfcUke9EXK93mjuhOKu2hc6kCuhdY34m30pkKFMYvAnMTtuI8xAAWBYbJBGg=
Message-ID: <21d7e9970411171408109dff1b@mail.gmail.com>
Date: Thu, 18 Nov 2004 09:08:52 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.10-rc2-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1100661812.17573.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041116014213.2128aca9.akpm@osdl.org>
	 <1100640653.16765.0.camel@krustophenia.net>
	 <20041116182233.097d9d85.akpm@osdl.org>
	 <21d7e99704111619218577ffd@mail.gmail.com>
	 <1100661812.17573.12.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> See my previous mail; FWIW almost no one uses the DRM for 3D on this
> card.  Many people do use the 2D HwMC stuff though.  Maybe this is not a
> big deal...
> 

I might merge up a DRM with the 3D part disabled, so the 2D stuff
works after 2.6.10 comes out, Alan wanted me to merge up all the
outstanding drms that have security issues and disable them for
non-root but someone pointed out the issues with making people run
untrusted things as root to be able to use them at all...

Dave.
