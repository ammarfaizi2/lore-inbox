Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282941AbRLRPgf>; Tue, 18 Dec 2001 10:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283876AbRLRPg0>; Tue, 18 Dec 2001 10:36:26 -0500
Received: from m749-mp1-cvx1b.edi.ntl.com ([62.253.10.237]:19182 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282547AbRLRPgP>; Tue, 18 Dec 2001 10:36:15 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181431.fBIEVW115600@pinkpanther.swansea.linux.org.uk>
Subject: Re: Scheduler ( was: Just a second ) ...
To: forveill@cfht.hawaii.edu (Thierry Forveille)
Date: Tue, 18 Dec 2001 14:31:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15390.53230.827019.336771@hoku.cfht.hawaii.edu> from "Thierry Forveille" at Dec 17, 2001 07:11:10 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a feeling that this discussion got sidetracked: cpu cycles burnt 
> in the scheduler indeed is non-issue, but big tasks being needlessly moved
> around on SMPs is worth tackling.]

Its not a non issue - 40% of an 8 way box is a lot of lost CPU. Fixing the
CPU bounce around problem also matters a lot - Ingo's speedups seen just by 
improving that on the current scheduler show its worth the work


