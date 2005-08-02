Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVHBFkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVHBFkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVHBFkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:40:23 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:55240 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261378AbVHBFkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:40:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=F1z+ZRO3//TErfTT6ic5DJdNZsDdtLUri9TPUUIqWgTIRvD2MrbIaLfeOOrLrpCqtYZQCyMuju/f6qXUarr5aKdwzSKR4iSOzAnoiO/xJcOAROrPqrap44khRtTk3k55wCZErBhqgVIK6HZZrC+jiXsCzmBJ3JsJ7hrLMp9tnR0=
Date: Tue, 2 Aug 2005 09:48:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Danny ter Haar <dth@picard.cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: busy usenet server: only stable kernel is 2.6.12-mm1, rest (including 2.6.13-rc4*) barfs within a few days
Message-ID: <20050802054822.GA28751@mipter.zuzino.mipt.ru>
References: <dci6n6$3tn$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dci6n6$3tn$1@news.cistron.nl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 09:47:18AM +0000, Danny ter Haar wrote:
> A tyan AMD64 opteron machine functioning as a usenet gateway really
> pumps some traffic a day (http://newsgate.newsserver.nl)
> Incoming traffic comes through a optical gig-E card (acenic)
> and local traffic is fed to our spool boxes through cupper gig-E
> (tigon3). Machine uses adaptec onboard scsi disks.
> At first i thought i had a hardware problem since no kernel would
> survive longer than 30 hours. Ofcourse i ran memtest for a couple
> of days. Than i compiled 2.6.12-mm1 and this kernel surviced 18 days 
> without a problem. But of course you now and then want to try 
> bigger&better(tm) kernels ;-)

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugzilla.kernel.org/show_bug.cgi?id=4982

Please, register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.

P. S.: Andrew Morton already asked for Oops output.

