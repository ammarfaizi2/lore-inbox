Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWHWTet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWHWTet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWHWTet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:34:49 -0400
Received: from main.gmane.org ([80.91.229.2]:33497 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965146AbWHWTet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:34:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: [patch 4/5] fail-injection capability for disk IO
Date: Wed, 23 Aug 2006 21:34:20 +0200
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <eciajs$1ip$1@sea.gmane.org>
References: <20060823113243.210352005@localhost.localdomain> <20060823113317.722640313@localhost.localdomain> <p73lkpf64gh.fsf@verdi.suse.de> <20060823121028.GE5893@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54b8ab55.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
> On Wed, Aug 23 2006, Andi Kleen wrote:
>> I think I would prefer a stackable driver instead of this hook.

I second this, preferrably a device-mapper target similar to dm-error.

> But that makes it more tricky to setup a test, since you have to change
> from using /dev/sda (for example) to /dev/stacked-driver.

Do you really think somebody would run such tests on otherwise normally
used devices?


regards
   Mario
-- 
There are two major products that come from Berkeley: LSD and UNIX.
We don't believe this to be a coincidence.    -- Jeremy S. Anderson

