Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTFYL4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 07:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTFYL4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 07:56:50 -0400
Received: from [81.2.110.254] ([81.2.110.254]:61178 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S263547AbTFYL4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 07:56:49 -0400
Subject: Re: Intel RAID hw card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joshua Penix <jpenix@binarytribe.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ertra@volny.cz
In-Reply-To: <1056505345.11051.18.camel@jepdesk.projectdesign.com>
References: <008901c33a9e$492aa080$c15af53e@dev>
	 <1056505345.11051.18.camel@jepdesk.projectdesign.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056542507.2460.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jun 2003 13:06:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-25 at 02:42, Joshua Penix wrote:
> driver, so I don't see any reason why yours won't work... unless your
> RAID controller model is newer (but it shouldn't be, I see specs on your
> model dating back to 2002) and the kernel just doesn't recognize its PCI
> ID yet.

s/Intel/Adaptec/ now

Older SCU raid cards think they are I2O, although apparently with
updated firmware they use gdth instead. The newer ones are the gdth
cards.

Alan

