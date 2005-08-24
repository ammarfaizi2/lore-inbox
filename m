Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVHXHsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVHXHsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVHXHsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:48:42 -0400
Received: from duero.optyma.com ([213.254.241.67]:59524 "EHLO duero.optyma.com")
	by vger.kernel.org with ESMTP id S1750730AbVHXHsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:48:41 -0400
Subject: Exporting symbols between modules
From: Sergio Paracuellos <sparacuellos@lock-linux.com>
To: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 09:48:38 +0200
Message-Id: <1124869718.3073.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm new in this list and I have some problems exporting symbols in a
module to see them in other module.

In the module I want to export the symbol I do:

tList list;
EXPORT_SYMBOL(list);

I compile it and install without any problem.

And in the module I want to use them I declare list with "extern"
prototype:

extern tList list;

When I compile the module It says me that list is undefined, and I don't
know what I am doing wrong.

Does anybody know what is happening? 

Maybe a makefile example would be appreciated... 

Thanks in advance.

Regards,

        Sergio 


