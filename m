Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVITQ73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVITQ73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVITQ73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:59:29 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:12921 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932678AbVITQ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:59:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pV5P5ROutbuUqBikQBAU3O+EKw7eLfvP90jdU0hOMvXL8akUbdCzL0nJ86YJKDeuEw63pwMin2SsU2eAXe4F0Y4mq14LSsScorkk3QcBfTlpFRVYCH+eSTcXOcl3ic86CoRmy0IWntt4gfXqMjMSAYtIeaM/1CDZ5FhVeGhjaYQ=
Date: Tue, 20 Sep 2005 21:09:58 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Sean <seanlkml@sympatico.ca>
Cc: Jan Dittmer <jdittmer@ppp0.net>, Alexander Nyberg <alexn@telia.com>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
Message-ID: <20050920170957.GA3083@mipter.zuzino.mipt.ru>
References: <200509201005.49294.gene.heskett@verizon.net> <20050920141008.GA493@flint.arm.linux.org.uk> <200509201025.36998.gene.heskett@verizon.net> <56402.10.10.10.28.1127229646.squirrel@linux1> <20050920153231.GA2958@localhost.localdomain> <BAYC1-PASMTP030BBDF3F9B2552DA9CF26AE950@cez.ice> <43303650.5030202@sfhq.hn.org> <BAYC1-PASMTP033EBAB483DBE4397549B2AE950@cez.ice> <43303C85.1020301@ppp0.net> <48312.10.10.10.28.1127235046.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48312.10.10.10.28.1127235046.squirrel@linux1>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:50:46PM -0400, Sean wrote:
> On Tue, September 20, 2005 12:44 pm, Jan Dittmer said:
> > I know, but for multiple people testing daily releases it's much easier to
> > say -git1 worked -git2 didn't. Sure, for searching the patch `git bisect`
> > is priceless but for regular testing the -gitx thing comes very handy.
> > Otherwise you can get a arbitrary intermediate state of linus tree if
> > you're pulling at the wrong moment. It's actually also faster I suppose
> > to get one patch than running `git pull` - at least with a cold cache
> > (it used to be in the 0.1 days of git).
> > Just my .02,
> 
> That's a good point.  Guess it would be useful if the HEAD commit was
> documented along with each -gitX release.

Look for 41-byte *.id files in snapshots dir.

