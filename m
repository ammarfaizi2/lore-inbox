Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVCITFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVCITFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVCITCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:02:14 -0500
Received: from main.gmane.org ([80.91.229.2]:29660 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262201AbVCITBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:01:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dan Stromberg <strombrg@dcs.nac.uci.edu>
Subject: huge filesystems
Date: Wed, 09 Mar 2005 10:53:48 -0800
Message-ID: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: seki.nac.uci.edu
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The group I work in has been experimenting with GFS and Lustre, and I did
some NBD/ENBD experimentation on my own, described at
http://dcs.nac.uci.edu/~strombrg/nbd.html

My question is, what is the current status of huge filesystems - IE,
filesystems that exceed 2 terabytes, and hopefully also exceeding 16
terabytes?

Am I correct in assuming that the usual linux buffer cache only goes to 16
terabytes?

Does the FUSE API (or similar) happen to allow surpassing either the 2T or
16T limits?

What about the "LBD" patches - what limits are involved there, and have
they been rolled into a Linus kernel, or one or more vendor kernels?

Thanks!


