Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSLQRPi>; Tue, 17 Dec 2002 12:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSLQRPi>; Tue, 17 Dec 2002 12:15:38 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17678 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265339AbSLQRPh>;
	Tue, 17 Dec 2002 12:15:37 -0500
Date: Tue, 17 Dec 2002 09:21:08 -0800
From: Greg KH <greg@kroah.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: pcibios functions left in m68knommu port
Message-ID: <20021217172107.GA21714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed the arch/m68knommu/kernel/comempci.c file, which contains
a lot of pcibios functions that are now removed from the rest of the
kernel.  Are these present for any specific reason, or would you be
willing to take a patch removing them?

thanks,

greg k-h
