Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWCXSnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWCXSnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCXSnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:43:42 -0500
Received: from bromo.msbb.uc.edu ([129.137.3.146]:21449 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S932561AbWCXSnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:43:41 -0500
To: linux-kernel@vger.kernel.org
Subject: why no option for 'ide=nocddma'?
Message-Id: <20060324184338.7A87511003E@bromo.msbb.uc.edu>
Date: Fri, 24 Mar 2006 13:43:38 -0500 (EST)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   It appears that the current Linux kernel still has trouble
verifying installation CDs for Fedora Core even in the FC5
release unless users pass the 'ide=nodma' kernel option. If
the problem with CDs using dma isn't going to be fully resolved,
why can't we have a 'ide=nocddma' kernel option that would only
apply to CD/DVD drives? The current situation is unfortunate
because installations end up with 'ide=nodma' in grub.conf
which severely slows down disk i/o. Thanks in advance for
any information on this issue.
                  Jack
ps Does this issue with dma and CD/DVD drives only apply to reads
or are writes effected as well?

