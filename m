Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268034AbUHVRGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268034AbUHVRGO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHVRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:06:14 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33260 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268030AbUHVRGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:06:13 -0400
Date: Sun, 22 Aug 2004 19:04:08 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Unai Garro <ugarro@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RTL-8139 Network card slow down on 2.6.8.1-mm
Message-ID: <20040822170408.GA26426@electric-eye.fr.zoreil.com>
References: <200408221850.34538.ugarro@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408221850.34538.ugarro@telefonica.net>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unai Garro <ugarro@telefonica.net> :
> Hi, it seems the last mm patches for 2.6.8.1 have caused my network card 
> (Realtek 8139)  to go buggy. 

*blush*

This should fix it:

http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-mm-revert.patch
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-10.patch
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-20.patch

--
Ueimor
