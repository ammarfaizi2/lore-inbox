Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbUDQSxp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbUDQSxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:53:45 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:14470 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264030AbUDQSxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:53:43 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Sat, 17 Apr 2004 20:53:38 +0200
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sf.net>,
       <linux-kernel@vger.kernel.org>, Frederic Detienne <fd@cisco.com>
References: <Pine.LNX.4.44L0.0404141226370.1474-100000@ida.rowland.org> <200404172031.09200.baldrick@free.fr>
In-Reply-To: <200404172031.09200.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404172053.38655.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 April 2004 20:31, Duncan Sands wrote:
> Alan, do you have a suggestion for how best to go from
> a struct usb_interface to an index?

(though probably usbfs shouldn't use indices at all,
just interface numbers and struct usb_interface).
