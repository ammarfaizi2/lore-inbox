Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424631AbWKPVOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424631AbWKPVOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424625AbWKPVOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:14:54 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:54543 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1424631AbWKPVOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:14:53 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Oliver Neukum <oliver@neukum.name>
Subject: Re: [linux-usb-devel] [PATCH] usb: microtek possible memleak fix
Date: Thu, 16 Nov 2006 22:14:58 +0100
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <200611161857.31030.m.kozlowski@tuxland.pl> <200611162141.14003.oliver@neukum.name>
In-Reply-To: <200611162141.14003.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611162215.00934.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> Ist there a reason you are replacing at least somewhat descriptive labels
> with numbers?

Yes.

To me these numbers speak more than not really descriptive labels like
out_kfree out_kfree2 etc. I look at the code and see the flow. The most
important thing here is the order in which the resources are allocated and
if something goes wrong deallocated. Hence the numbers.

Anyway if that's a problem I can rewrite it.

-- 
Regards,

	Mariusz Kozlowski
