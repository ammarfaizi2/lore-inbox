Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTL2Ruf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTL2Ruf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:50:35 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:57570 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263834AbTL2Rue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:50:34 -0500
Date: Mon, 29 Dec 2003 18:49:51 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031229174951.GA304@louise.pinerecords.com>
References: <20031229173853.A32038@beton.cybernet.src> <Pine.LNX.4.58.0312300045070.24938@silk.corp.fedex.com> <20031229183302.B32137@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031229183302.B32137@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-29 2003, Mon, 18:33 +0100
Karel Kulhavý <clock@twibright.com> wrote:

> > You'll need to load the usb modules using initrd ramdisk, then switch root
> > to the usb device to continue booting the system.
> 
> This is the problem #2. I am not able to remount /. "device or resource busy".
> How do I remount the "/"?

/sbin/mount -o remount,rw /

-- 
Tomas Szepe <szepe@pinerecords.com>
