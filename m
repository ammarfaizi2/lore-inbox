Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262028AbTCHO12>; Sat, 8 Mar 2003 09:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbTCHO12>; Sat, 8 Mar 2003 09:27:28 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:443 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S262028AbTCHO12>;
	Sat, 8 Mar 2003 09:27:28 -0500
Date: Sat, 8 Mar 2003 15:37:45 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_init_cpio fixes for 2.5.64
Message-ID: <20030308143745.GB7234@h55p111.delphi.afb.lu.se>
References: <20030305060817.GC26458@kroah.com> <20030308004249.GA23071@kroah.com> <20030308004340.GB23071@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308004340.GB23071@kroah.com>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18rfSM-0002b2-00*bq/woNoRucw* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 04:43:40PM -0800, Greg KH wrote:
> 
> ChangeSet 1.1124, 2003/03/07 16:39:06-08:00, greg@kroah.com
> 
> gen_init_cpio: Add the ability to add files to the cpio image.

Have you been able to boot the kernel with a cpio-archive that contains
files larger than a few k? The kernel crashes on me when writing to the file
in ramfs.
It crashes i the third or forth flush_window or so..

--
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
