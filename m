Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTGAQ6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTGAQ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:58:44 -0400
Received: from moraine.clusterfs.com ([216.138.243.178]:33160 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262874AbTGAQ6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:58:38 -0400
Date: Tue, 1 Jul 2003 11:12:45 -0600
From: "Peter J. Braam" <braam@clusterfs.com>
To: chyang@clusterfs.com
Cc: Miles T Lane <miles_lane@yahoo.com>, linux-kernel@vger.kernel.org,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, Ben Pfaff <pfaffben@debian.org>
Subject: Re: 2.5.73-bk5 -- intermezzo.ko needs unknown symbol set_fs_root, vga16fb.ko needs unknown symbol screen_info
Message-ID: <20030701171245.GZ9463@peter.cfs>
References: <20030628014710.32726.qmail@web40602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628014710.32726.qmail@web40602.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, 

This requires a small patch to the kernel/ksyms.c file and possibly a
prototyp in fs.h. 

Can you fix it and send to Linus.

- Peter -

On Fri, Jun 27, 2003 at 06:47:10PM -0700, Miles T Lane wrote:
> if [ -r System.map ]; then /sbin/depmod -ae -F
> System.map  2.5.73-bk5; fi
> WARNING:
> /lib/modules/2.5.73-bk5/kernel/fs/intermezzo/intermezzo.ko
> needs unknown symbol set_fs_root
> WARNING:
> /lib/modules/2.5.73-bk5/kernel/fs/intermezzo/intermezzo.ko
> needs unknown symbol set_fs_pwd
> WARNING:
> /lib/modules/2.5.73-bk5/kernel/drivers/video/vga16fb.ko
> needs unknown symbol screen_info
> 
> 
> __________________________________
> Do you Yahoo!?
> SBC Yahoo! DSL - Now only $29.95 per month!
> http://sbc.yahoo.com
- Peter -
