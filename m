Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbTIBLTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTIBLTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:19:33 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:6297 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S261167AbTIBLSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:18:08 -0400
Date: Tue, 2 Sep 2003 13:18:03 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030902111756.GL14380@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030831120605.08D6.CHRIS@heathens.co.nz> <20030902080733.GA14380@charite.de> <20030902124717.B1221@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902124717.B1221@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer <aebr@win.tue.nl>:
> On Tue, Sep 02, 2003 at 10:07:33AM +0200, Ralf Hildebrandt wrote:
> 
> > I got some more events, and today I even was able to reproduc the
> > "CTRL-is-stuck" problem.
> > 
> > I was able to get the key unstuck by switching back and forth between
> > dirrerent FB consoles and by pushing and releaseing CTRL in them...
> 
> Yesterday's data sufficed, and I suppose the patch I gave solves
> this problem. Now that you send this, we can verify that each time
> there is a problem we have had a double release just before, and
> that release was an e0 xx combination.

Excellent. I rebuild my kernel including your patch; I shall reboot
soon :)

> This bug is understood.

I'll get back to you once I verify that the problem doesn't occur
anymore.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
* Andries Brouwer <aebr@win.tue.nl>:
> On Tue, Sep 02, 2003 at 10:07:33AM +0200, Ralf Hildebrandt wrote:
> 
> > I got some more events, and today I even was able to reproduc the
> > "CTRL-is-stuck" problem.
> > 
> > I was able to get the key unstuck by switching back and forth between
> > dirrerent FB consoles and by pushing and releaseing CTRL in them...
> 
> Yesterday's data sufficed, and I suppose the patch I gave solves
> this problem. Now that you send this, we can verify that each time
> there is a problem we have had a double release just before, and
> that release was an e0 xx combination.

Excellent. I rebuild my kernel including your patch; I shall reboot
soon :)

> This bug is understood.

I'll get back to you once I verify that the problem doesn't occur
anymore.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
