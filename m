Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTA0DgG>; Sun, 26 Jan 2003 22:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTA0DgF>; Sun, 26 Jan 2003 22:36:05 -0500
Received: from spiderman.spectsoft.com ([216.126.222.67]:57866 "EHLO
	trashbin1.spectsoft.com") by vger.kernel.org with ESMTP
	id <S267117AbTA0DgF>; Sun, 26 Jan 2003 22:36:05 -0500
Subject: kiovec/kiobuf replacement
From: Jason Howard <lists@spectsoft.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SpectSoft, LLC
Message-Id: <1043639121.1447.21.camel@bmagic.spectsoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 26 Jan 2003 19:45:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

What is the correct change in code/mindset needed to replace the
kiovec/kiobuf routines?  I am currently using there routines to do a
scatter gather DMA from a user space buffer to/from a PCI video frame
buffer device.  Should I approach this problem differently?  The user
space buffer can be up to 8MB in size.

Thanks,
Jason

-- 
 Jason Howard

Professional:
  SpectSoft, LLC
  http://www.spectsoft.com  jason@spectsoft.com      
  Phone: +1.209.847.7812    Fax: +1.209.847.7859
Personal:
  http://www.psinux.org     jason@psinux.org
  Cell: +1.209.968.1289
  Text Message: jasonsphone@psinux.org


