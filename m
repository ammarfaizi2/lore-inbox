Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288310AbSAHUq0>; Tue, 8 Jan 2002 15:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288317AbSAHUqU>; Tue, 8 Jan 2002 15:46:20 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:15723 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288310AbSAHUqE>; Tue, 8 Jan 2002 15:46:04 -0500
Date: Tue, 8 Jan 2002 15:46:03 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: extern struct hd_struct *sd; ?
Message-ID: <20020108154603.A10576@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

does anyone know why is sd external? It is mentioned in sd.h,
together with the macro SD_PARTITION that is needed to access it,
but no drivers make use of it. On the other hand, sd_mod does not
export the symbol sd.

-- Pete
