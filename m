Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUDVS6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUDVS6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbUDVS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:58:48 -0400
Received: from s383.jpl.nasa.gov ([137.79.94.127]:4494 "EHLO s383.jpl.nasa.gov")
	by vger.kernel.org with ESMTP id S264638AbUDVS6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:58:41 -0400
Subject: atomic_t and atomic_inc
From: Al Niessner <Al.Niessner@jpl.nasa.gov>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Jet Propulsion Laboratory
Message-Id: <1082660320.28900.193.camel@morte.jpl.nasa.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-9mdk 
Date: Thu, 22 Apr 2004 11:58:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, I am not subscribed to this list so please reply to me directly
if you wish a timely response to any questions. In any case, I will lurk
in the archives for responses.

I am using atomic_t to count interrupts from some piece of hardware.
These interrupts come at a fairly high rate -- 10 KHz and higher. The
problem is, will I get increment problem at the limit of atomic_t or
will it wrap around without error? I read the docs (man pages, on-line
api docs, this list and other stuff) and none of them talk about the
behavior of atomic_t at the boundaries. Furthermore, am I guaranteed of
any boundary behavior across platforms?

Thank you in advance for any and all help.

-- 
Al Niessner <Al.Niessner@jpl.nasa.gov>
Jet Propulsion Laboratory

All opinions stated above are mine and do not necessarily reflect 
those of JPL or NASA.

 ----
| dS | >= 0
 ----

