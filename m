Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSKTImg>; Wed, 20 Nov 2002 03:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbSKTImg>; Wed, 20 Nov 2002 03:42:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34322 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261426AbSKTImf>;
	Wed, 20 Nov 2002 03:42:35 -0500
Date: Wed, 20 Nov 2002 00:43:03 -0800
From: Greg KH <greg@kroah.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Can't allocate memory when loading a module 2.5.48-bk
Message-ID: <20021120084303.GB22936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Linus's latest bk tree (plus some USB patches) I get the following
error when trying to load the parport.o module:

# modprobe parport
FATAL: Error inserting /lib/modules/2.5.48/kernel/parport.o: Cannot allocate memory

Any ideas?

thanks,

greg k-h
