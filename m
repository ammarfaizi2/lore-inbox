Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVCLS4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVCLS4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 13:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVCLS4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 13:56:04 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:8228 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261994AbVCLSz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 13:55:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=f11gq/RjIJbA5sD4SzEPm49rMtk1HAU+75cJUm55TAIaP8WHaMiTqy54EZoD4nmMlOeZNlerUEO17mVRksJOpF1fPGpNXe0GPiXZyErCFB0QfZiXFhnhUtph2Y5Rxjc9nWOVJ5pqxwDY3uceu0M1MF3cjC39RqMakRJK8iUSkwc=
Message-ID: <9e4733910503121055444ef328@mail.gmail.com>
Date: Sat, 12 Mar 2005 13:55:58 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <9e473391050312082777a02001@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <20050311102920.GB30252@elf.ucw.cz>
	 <9e473391050312082777a02001@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005 11:27:25 -0500, Jon Smirl <jonsmirl@gmail.com> wrote:
> Xen just posted patches for using kgdb between two instances but I
> don't see how they get out of the interrupt acknowledge problem
> either.

I just talked to the Xen people. They don't have a solution either.
They did point out that this is not a problem with MSI on PCI Express.

-- 
Jon Smirl
jonsmirl@gmail.com
