Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSGEPVM>; Fri, 5 Jul 2002 11:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSGEPVL>; Fri, 5 Jul 2002 11:21:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58055 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317472AbSGEPVL>;
	Fri, 5 Jul 2002 11:21:11 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFC559AB05.FD04F581-ON85256BED.005475E9@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Fri, 5 Jul 2002 10:23:45 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 |March 28, 2002) at
 07/05/2002 11:23:40 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-02 14:17:02, Joe wrote:

>This is a horrible hack to get around the fact that ext3 uses the
>b_private field for its own purposes after the buffer_head has been
>handed to the block layer (it doesn't just use b_private when in the
>b_end_io function).  Is this acceptable behaviour ?  Other > filesystems
>do not have similar problems as far as I know.

Under what conditions does ext3 exhibit this behaviour? In EVMS, we have
been stacking the b_private field (for many months), and have not seen any
problems or have had any problems reported with ext3.

Mark


