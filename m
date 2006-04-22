Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWDVRwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDVRwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWDVRwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:52:08 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54429 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750857AbWDVRwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:52:05 -0400
X-ME-UUID: 20060422084727256.3E9CD2400154@mwinf1004.wanadoo.fr
Date: Sat, 22 Apr 2006 10:47:26 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060422084726.GB8079@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	rth@twiddle.net
References: <20060422011205.A1270@jurassic.park.msu.ru> <20060421224917.34BE5DBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421224917.34BE5DBA1@gherkin.frus.com>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 05:49:17PM -0500, Bob Tracy wrote:
> > Second, strncpy was mostly used in drivers that are rarely (if at all)
> > used on alpha.
> 
> Which was evidently the case, since this problem didn't surface until
> the strncpy() call was added to sd.c.

Yeah most of the drivers I was looking at use snprintf and friends.

> I'm happy to report my Alpha is now up and running on 2.6.17-rc2, so
> the fix works for me.  Thanks to discussion participants for their time
> and trouble!

Thanks to you too:
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

