Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUAWTOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266641AbUAWTOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:14:01 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:44418 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S266640AbUAWTN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:13:58 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16401.29300.517468.595015@jik.kamens.brookline.ma.us>
Date: Fri, 23 Jan 2004 14:13:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Equivalent of 2.4's "CONFIG_FILTER" in 2.6?
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone tell me what equivalent of 2.4's "CONFIG_FILTER" option
(see below for its description from Configure.help) is in 2.6?  And if
there's a documentation file somewhere I should have looked to find
this information, can you please tell me where it is?

Thanks,

  jik

Socket filtering
CONFIG_FILTER
  The Linux Socket Filter is derived from the Berkeley Packet Filter.
  If you say Y here, user-space programs can attach a filter to any
  socket and thereby tell the kernel that it should allow or disallow
  certain types of data to get through the socket.  Linux Socket
  Filtering works on all socket types except TCP for now.  See the
  text file <file:Documentation/networking/filter.txt> for more
  information.

  You need to say Y here if you want to use PPP packet filtering
  (see the CONFIG_PPP_FILTER option below).

  If unsure, say N.
