Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTIWUIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTIWUIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:08:50 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6918 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S263556AbTIWUIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:08:49 -0400
Date: Tue, 23 Sep 2003 22:06:45 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Steven Cole <elenstev@mesatop.com>, "J.A. Magallon" <jamagallon@able.es>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: ATTACK TO MY SYSTEM
Message-ID: <20030923200645.GG589@alpha.home.local>
References: <5.2.1.1.2.20030923114213.01b36e78@pop.gmx.net> <20030923134023.GA3032@werewolf.able.es> <1064328224.1995.236.camel@spc9.esa.lanl.gov> <20030923115039.A30231@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923115039.A30231@animx.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:50:39AM -0400, Wakko Warner wrote:
 
> I'm running my own mailserver and it's hard not to accept it.  I have
> basically done checks in the from and to headers.  If it appears as a virus,
> i lockout the smtp sender.  It's not permenant.  When the virus stops, i
> unblock every one.

I've noticed that they *ALL* have their From:, To:, and Subject: written in
uppercase. So it's really easy to filter them out depending on the tools used.
If a mail header either matches ^FROM:, ^TO: or ^SUBJECT: then it has high
chances to be a spam/virus. I checked all my recent mails and a few months
back in LKML and did not found anything except spam/viruses which match this.
At least, we should be lucky that these virus writers don't fully respect
protocols...

HTH,
Willy

