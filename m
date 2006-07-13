Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWGMNoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWGMNoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGMNoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:44:20 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:37662 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750863AbWGMNoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:44:19 -0400
In-Reply-To: <44B5C971.7030403@us.ibm.com>
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF590AF8CD.54E93D95-ON422571AA.004AFB01-422571AA.004B7748@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Thu, 13 Jul 2006 15:44:17 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF268 | April 6, 2006) at
 13/07/2006 15:47:13
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badari

Your new patch compiles and seems to work.

Badari Pulavarty <pbadari@us.ibm.com> wrote on 07/13/2006 06:17:53 AM:
> Badari Pulavarty wrote:
> > Hi Micheal,
> >
> > I made fixes to hypfs to fit new vfs ops interfaces. I am not sure if
> > we really
> > need to vectorize aio interfaces, can you check and see if this is okay
?
> > And also, I am not sure what hypfs_aio_write() is actually doing.
> > It doesn't seem to be  doing with "buf" ?

The hypfs write function currently is only used to trigger the update
process of hypfs. We just ignore the buffer.

Thanks

Michael

