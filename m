Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVLPPfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVLPPfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLPPfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:35:41 -0500
Received: from srvr5.engin.umich.edu ([141.213.75.23]:60361 "EHLO
	srvr5.engin.umich.edu") by vger.kernel.org with ESMTP
	id S1751301AbVLPPfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:35:34 -0500
From: Matt Reuther <mreuther@umich.edu>
Organization: The Knights Who Say... Ni!
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 10:36:58 -0500
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161036.59333.mreuther@umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't this patch specifically for the -mm kernel and not mainline? How can 
anyone using a binary driver provide any feedback on an -mm kernel? The 
binary driver taints the kernel, so bug reports are useless.

Furthermore, if you aren't interested in debugging the kernel, why would you 
run the -mm tree or why can't you hack/patch the 8k stacks back in?
