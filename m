Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUHMXKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUHMXKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUHMXKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:10:05 -0400
Received: from the-village.bc.nu ([81.2.110.252]:51674 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267700AbUHMXJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:09:57 -0400
Subject: Re: [Patch} to fix oops in olympic token ring driver on media
	disconnect
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Horman <nhorman@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pete Zaitcev <zaitcev@redhat.com>, mike_phillips@urscorp.com
In-Reply-To: <411D126B.6090303@redhat.com>
References: <411D126B.6090303@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092434830.25002.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:07:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 20:11, Neil Horman wrote:
> the olympic_close routine was waiting on.  This patch cleans that up.
> 
> Tested by me, on 2.4 and 2.6 with good, working results, and no more oopses.

Should it not be blocking the IRQs on the chip as well ?

