Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSGRQhk>; Thu, 18 Jul 2002 12:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSGRQhj>; Thu, 18 Jul 2002 12:37:39 -0400
Received: from copper.ftech.net ([212.32.16.118]:9156 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S318263AbSGRQhj>;
	Thu, 18 Jul 2002 12:37:39 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF451@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Closing a socket
Date: Thu, 18 Jul 2002 17:36:43 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have implemented a new socket address family and have noted that
from a multi-threaded application, if a thread calls close(fd) while a
second thread has a blocking read outstanding, the sockets release() is not
called.  Is this correct?  How can one unblock the read in order to do the
close.


Thanks

Kevin
