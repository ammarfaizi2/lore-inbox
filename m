Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945933AbWBCUHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945933AbWBCUHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945936AbWBCUHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:07:25 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:21903 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1945933AbWBCUHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:07:24 -0500
Date: Fri, 3 Feb 2006 21:04:15 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Roger Heflin <rheflin@atipa.com>, Phillip Susi <psusi@cfl.rr.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: RAID5 unusably unstable through 2.6.14
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C99D3@otce2k03.adaptec.com>
Message-ID: <Pine.LNX.4.60.0602032102420.26896@kepler.fjfi.cvut.cz>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C99D3@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Salyzyn, Mark wrote:

> Martin Drab sez:
> > S.M.A.R.T. should be able to do this. But last time I've 
> > checked it wasn't 
> > working with Linux and SCSI/SATA. Is this working now?
> 
> Smartctl works with the latest patches to the aacraid driver to SAS and
> SATA products (no_uld_patch submitted originally in December)

Is it in mainline allready? Or do I have to get it somewhere else?

> >> Run the Verify (or Verify with Fix) Task on the controller, the
> report
> >> will indicate the reasons for inconsistencies.
> >How do I run that? Any special tools for that?
> 
> Can be triggered in the BIOS, or using the Adaptec Management Tools.

BIOS media verification completes successfully after the low-level format. 
Otherwise I wouldn't have started to install it on the same disk again of 
course.

Martin
