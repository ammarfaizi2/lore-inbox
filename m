Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbWAFSPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWAFSPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWAFSPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:15:52 -0500
Received: from mail1.kontent.de ([81.88.34.36]:60615 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932677AbWAFSPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:15:52 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: need for packed attribute
Date: Fri, 6 Jan 2006 19:15:43 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061915.43961.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there any architecture for which packed is required in structures like this:

/* All standard descriptors have these 2 fields at the beginning */
struct usb_descriptor_header {
	__u8  bLength;
	__u8  bDescriptorType;
};

	Regards
		Oliver
