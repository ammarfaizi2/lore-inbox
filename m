Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTLCOvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 09:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTLCOvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 09:51:38 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:37517 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S264569AbTLCOvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 09:51:37 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 includes Andrea's VM?
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Wed, 03 Dec 2003 09:51:36 -0500
Message-ID: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a machine with 12GB of RAM, and I've been running a 2.4.22-era
kernel with Andrea's patches on it, otherwise it dies from lack of
lowmem.  

The latest -aa patch is for 2.4.23-pre6, but I see in the 2.4.23
Changelog that at least some bits of Andrea's VM were merged.  Should
I be able to run a vanilla 2.4.23 on this box?

(Well, vanilla modulo XFS, but I know how to apply patches ;-)

For the record, I tried hand-merging the last -aa patch into
2.4.22-rc5 last week, but it wasn't 100% stable so I may have fudged
something.  (It would lock up when the console blanked...)

Ian


