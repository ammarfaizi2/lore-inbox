Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTDWTEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTDWTEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:04:48 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:36788 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S264265AbTDWTDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:03:55 -0400
Date: Wed, 23 Apr 2003 15:12:05 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: FileSystem Filter Driver
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304231515_MC3-1-35AB-AB17@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks wrote:

.> Proper kernel auditing is harder than it looks.  Check the LSM mailing list
.> archives for the last attempt to get auditing into the kernel - the idea
.> was basically dropped.
.> ...<snip>...


  In addition to all the points you covered, you also have to figure
out what to do if the log medium fills up or fails.  In a high security
environment the only thing you can do is panic the system immediately,
because (unaudited) bad things might already be happening.  You also
have to configure the system so it will not boot into multiuser
mode if the log has failed.  (And *then* you get to deal with clueless
admins who will disable that feature in their desperation to get
the system up and running, but that's not really a technical problem.)

------
 Chuck
