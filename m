Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVCDLE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVCDLE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVCDLE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:04:26 -0500
Received: from mx1.mail.ru ([194.67.23.121]:57904 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262770AbVCDLDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:03:17 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Hans-Christian Egtvedt <hc@mivu.no>
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Date: Fri, 4 Mar 2005 14:03:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no>
In-Reply-To: <1109932223.5453.16.camel@charlie.itk.ntnu.no>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200503041403.37137.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 12:30, Hans-Christian Egtvedt wrote:

> I've ported the works from Chris Collins so the drivers compiles without
> warnings and works (for me) with Linux 2.6.10 and 2.6.11.

> Any comments on the driver would be much appreciated.

> +struct itmtouch_dev {

> +       int                     refcount; //

There is already generic interface for reference-counted objects. See
lib/kref.c and kref documentation at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110987233406767&w=2

	Alexey
