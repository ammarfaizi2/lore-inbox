Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164185AbWLHAJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164185AbWLHAJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164194AbWLHAJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:09:34 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4315 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164185AbWLHAJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:09:33 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH 2.6.19] drivers/media/video/cpia2/cpia2_usb.c: Free previously allocated memory (in array elements) if kmalloc() returns NULL.
Date: Fri, 8 Dec 2006 01:09:26 +0100
User-Agent: KMail/1.9.5
Cc: Amit Choudhary <amit2030@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061206211317.b996bc34.amit2030@gmail.com> <200612080050.53895.m.kozlowski@tuxland.pl> <Pine.LNX.4.64N.0612071602540.3592@attu4.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0612071602540.3592@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612080109.27018.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> > Just for future. Shorter and more readable version of your for(...) thing:
> > 
> > 	while (i--) {
> > 		...
> > 	}
> > 
> 
> No, that is not equivalent.
> 
> You want
> 	while (i-- >= 0) {
> 		...
> 	}
> 

Not really. That will stop at -1 not 0.

-- 
Regards,

	Mariusz Kozlowski
