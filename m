Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263601AbUESAaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUESAaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUESAaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:30:09 -0400
Received: from babyruth.hotpop.com ([38.113.3.61]:1418 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S263601AbUESAaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:30:05 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
To: James Lamanna <jamesl@appliedminds.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting i815 Framebuffer working?!
Date: Wed, 19 May 2004 08:30:32 +0800
User-Agent: KMail/1.5.4
Cc: adaplas@pol.net
References: <409AD0E2.4040705@appliedminds.com>
In-Reply-To: <409AD0E2.4040705@appliedminds.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405072155.29622.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 May 2004 07:57, James Lamanna wrote:

> Relevant Statements from dmesg:
> agpgart: Detected an Intel i815 Chipset.
> agpgart: Maximum main memory to use for agp memory: 438M
> agpgart: AGP aperture is 64M @ 0xe0000000
> i810fb: probe of 0000:00:02.0 failed with error -22
> ^^^^ Not promising... :)

Make sure you set hsync1, hsync2 , vsync1 and vsync2 in your boot parameters.

For monitors that can do 1024x768@50Hz, the following should work.

hysnc1 = 30, hsync2 = 48, vsync1= 50 vsync2 = 85

Tony



