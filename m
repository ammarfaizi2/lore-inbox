Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWC1RSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWC1RSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWC1RSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:18:14 -0500
Received: from main.gmane.org ([80.91.229.2]:11443 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751191AbWC1RSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:18:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Tue, 28 Mar 2006 09:16:40 -0800
Message-ID: <87hd5iebgn.fsf@benpfaff.org>
References: <200603141619.36609.mmazur@kernel.pl>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
	<4426A5BF.2080804@tremplin-utc.net>
	<200603261609.10992.rob@landley.net>
	<44271E88.6040101@tremplin-utc.net>
	<5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
	<Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:XW7JxSGJk5i3ea4WnCNjjirh8UA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>> Eh, not really.  "__inline__" is GCC-specific and probably won't work in other
>> compilers (unless you did "#define __inline__", which would bloat the code a
>> lot).
>>
> But ___inline is a C99 keyword, isnot it?

___inline is not, but inline is.
-- 
"Platonically Evil Monkey has been symbolically representing the darkest 
 fears of humanity since the dawn of literature and religion, and I think
 I speak for everyone when I give it a sidelong glance of uneasy recognition 
 this evening." --Scrymarch

