Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVHKUCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVHKUCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVHKUCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:02:07 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:30375
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932390AbVHKUCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:02:06 -0400
Date: Thu, 11 Aug 2005 16:00:17 -0400
From: Sonny Rao <sonny@burdell.org>
To: James.Smart@emulex.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: lpfc driver in 2.6.13-rc6 broken on ppc64 ?
Message-ID: <20050811200017.GA3951@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am having problems using some older Emulex fibre adapters on a
ppc64 machine, whenever I load the lpfc driver I get a large number of 

"lpfc 0001:d8:01.0: 1:0321 Unknown IOCB command Data: x0 x3 x0 x0"

with several hundred messages per adapter

and finally I get this message:

lpfc 0001:d8:01.0: 1:0222 Initial FLOGI timeout
lpfc 0001:d8:01.0: 1:0127 ELS timeout Data: x4000000 xfffffe x8a x23


Is this a known issue ?

Let me know if you need patches tested, thanks.

Sonny Rao
IBM LTC Performance


