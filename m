Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbVKRMnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbVKRMnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbVKRMnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:43:52 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:61911 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1161093AbVKRMnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:43:52 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc1-mm1
Date: Fri, 18 Nov 2005 07:43:44 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20051117111807.6d4b0535.akpm@osdl.org>
In-Reply-To: <20051117111807.6d4b0535.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511180743.44838.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 14:18, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1

Hi,

Any ideas why the mousedev module does not load automaticly with 15-rc1-mm1?

With 14-rc4-mm1 all is ok.  With 15-rc1-mm1 I have no /dev/input which causes Xorg fun.  The 
mouse is connected to a usb hub and is detected when I unplug and replug it.  I used make oldconfig 
from a 14-rc4-mm1 config.  Dist is debian amd64 unstable and is up to date.

When I manually modprobe mousedev things work as expected

DRM works fine and dri is enabled.

Ideas,
Ed Tomlinson
