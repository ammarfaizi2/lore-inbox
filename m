Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVBWKEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVBWKEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 05:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVBWKEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 05:04:46 -0500
Received: from gate.firmix.at ([80.109.18.208]:9137 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261445AbVBWKE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 05:04:29 -0500
Subject: Re: uninterruptible sleep lockups
From: Bernd Petrovitsch <bernd@firmix.at>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Chris Friesen <cfriesen@nortel.com>,
       Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200502230105.j1N15e56005773@laptop11.inf.utfsm.cl>
References: <421A3414.2020508@nodivisions.com>
	 <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
	 <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no>
	 <421B14A8.3000501@nodivisions.com>
	 <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com>
	 <421B9018.7020007@nodivisions.com>
	 <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl>
	 <421B9C86.8090800@nortel.com>
	 <200502230105.j1N15e56005773@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1109153053.7808.28.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Wed, 23 Feb 2005 11:04:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 22:05 -0300, Horst von Brand wrote:
> Chris Friesen <cfriesen@nortel.com> said:
[...]
> > Maybe I'm on crack, but would it not be technically possible to have all 
> > resource usage be tracked so that when a task tries to do something and 
> > hangs, eventually it gets cleaned up?
> 
> Sure. But there is /no way/ to know if the task will ever do something
> (Turing's undecibility sees to that, even with perfect hardware), so the

ACK. But if root says "it will not come" (through whatever method), the
we have a decision good enough for real life.
The downside is that we need for each usage of these items explicit
checks and cleanup code (which wants to be written and tested) after
each usage.
Does this pay off?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

