Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263949AbRFEJoM>; Tue, 5 Jun 2001 05:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263950AbRFEJoC>; Tue, 5 Jun 2001 05:44:02 -0400
Received: from kivc.vstu.vinnica.ua ([62.244.53.242]:57474 "EHLO
	kivc.vstu.vinnica.ua") by vger.kernel.org with ESMTP
	id <S263949AbRFEJnm>; Tue, 5 Jun 2001 05:43:42 -0400
Date: Tue, 5 Jun 2001 12:37:55 +0300
From: Bohdan Vlasyuk <bohdan@kivc.vstu.vinnica.ua>
To: linux-kernel@vger.kernel.org
Subject: isolating process..
Message-ID: <20010605123755.B5998@kivc.vstu.vinnica.ua>
Mail-Followup-To: Bohdan Vlasyuk <bohdan>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Logged: Logged by kivc.vstu.vinnica.ua as f559btp06205 at Tue Jun  5 12:37:55 2001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

Is it possible by any means to isolate any given process, so that
it'll be unable to crash system. Suppose all the process needs is
stdin, stdout, and CPU time. Can Linux guarantee that given process
won't hurt system stability ? Let us soppose that we have ideal CPU
without mistakes. How can I limit CPU time/Mem Usage for given
process?

Please, supply ANY suggestions.

My ideas:

create some user, and decrease his ulimits up to miminum of 1 process,
0 core size, appropriate memory/ etc.


Thanks!
