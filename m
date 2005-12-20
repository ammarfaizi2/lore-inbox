Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVLTR2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVLTR2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVLTR2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:28:10 -0500
Received: from outmx021.isp.belgacom.be ([195.238.2.202]:32710 "EHLO
	outmx021.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750717AbVLTR2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:28:09 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Date: Tue, 20 Dec 2005 18:27:56 +0100
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>
References: <200512210310.51084.kernel@kolivas.org>
In-Reply-To: <200512210310.51084.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512201827.56387.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 December 2005 17:10, Con Kolivas wrote:
> Here is the latest version of the dynticks code incorporating a huge
> rewrite correcting all the known problems with the previous code.

Works nicely sofar. One slight bug in the pmstats code, the interval setting 
doesn't work because of a missing else clause.

One thing I'm curious about (and haven't tested yet): does this also work with 
S3 suspend to ram? Last dynticks I tried had issues with that...

Thanks,

Jan

-- 
Algebraic symbols are used when you do not know what you are talking about.
		-- Philippe Schnoebelen
