Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbRFGVEa>; Thu, 7 Jun 2001 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbRFGVEU>; Thu, 7 Jun 2001 17:04:20 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:1555 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263141AbRFGVEM>;
	Thu, 7 Jun 2001 17:04:12 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106072102.f57L2gm377429@saturn.cs.uml.edu>
Subject: Re: temperature standard - global config option?
To: lk@Aniela.EU.ORG (L. K.)
Date: Thu, 7 Jun 2001 17:02:42 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        unlisted-recipients:;;;@Aniela.EU.ORG; (no To-header on input)
In-Reply-To: <Pine.LNX.4.21.0106071519120.3702-100000@ns1.Aniela.EU.ORG> from "L. K." at Jun 07, 2001 03:20:03 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L. K. writes:

> Why not make it in Celsius ? Is more easy to read it this way.

No, because then the software must handle negative numbers for
cooled computers. CentiKelvin is fine. Do C=cK/100-273.15 if you
really must... but you still have a number that is useless to
a human. Humans need a seconds-to-destruction value or an alarm.

Negative temperatures do not really exist.





