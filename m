Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277559AbRJETSB>; Fri, 5 Oct 2001 15:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277558AbRJETRv>; Fri, 5 Oct 2001 15:17:51 -0400
Received: from sushi.toad.net ([162.33.130.105]:48797 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277554AbRJETRn>;
	Fri, 5 Oct 2001 15:17:43 -0400
Subject: Re: [PATCH] PnPBIOS additional fixes
To: linux-kernel@vger.kernel.org
Date: Fri, 5 Oct 2001 15:17:42 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011005191742.8128042@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay the original version of the patch was included in -ac5.
Thanks, Alan.  I'll submit a new patch against -ac5 with the
improved error handling.  I think I'll work a bit on examining
the status returned by the BIOS and providing some printk feedback
in the event of an error.  (get_dev_node shouldn't ever return
anything but 0, and if it does then something is wrong.)

Cheers
--
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_mail.com)
