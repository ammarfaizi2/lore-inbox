Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUEMVth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUEMVth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbUEMVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:49:37 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:61122 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264551AbUEMVtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:49:36 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PATCH: (as279) Don't delete interfaces until all are unbound
Date: Thu, 13 May 2004 23:23:49 +0200
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, Nuno Ferreira <nuno.ferreira@graycell.biz>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sf.net>
References: <Pine.LNX.4.44L0.0405131656470.651-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0405131656470.651-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405132323.49496.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, all is clear to me now.  By the way, I guess it would be
better (stylistically speaking) to use
		dev->actconfig = NULL;
rather than
                dev->actconfig = 0;
in usb_disable_device.

Thanks a lot,

Duncan.
