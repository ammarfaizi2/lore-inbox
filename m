Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSEBVAR>; Thu, 2 May 2002 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSEBVAQ>; Thu, 2 May 2002 17:00:16 -0400
Received: from ns.suse.de ([213.95.15.193]:3592 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315420AbSEBVAP>;
	Thu, 2 May 2002 17:00:15 -0400
Date: Thu, 2 May 2002 23:00:14 +0200
From: Dave Jones <davej@suse.de>
To: Mark Orr <markorr@intersurf.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12-dj1:  IDE trouble - RZ1000 still won't finish booting
Message-ID: <20020502230014.U16935@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Mark Orr <markorr@intersurf.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502154425.45437b42.markorr@intersurf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:44:25PM -0500, Mark Orr wrote:

 > hda: task_mulout_intr: error=0x04  { DriveStatusError }
 > 
 > then several of these:
 > 
 >    { task_mulout_intr }
 > hda:  ide_set_handler: handler not null  old=<some hex> new=<some other hex>
 > bug: kernel timer added twice

Yup, I saw the same problem with my dual P5 a few nights ago, shortly
before it ate the filesystem.  It's a known problem, and several people
claim they have a handle on it, but no-one seems in a hurry to fix it.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
