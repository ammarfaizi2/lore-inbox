Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbTJJJWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTJJJWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:22:14 -0400
Received: from c-36a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.54]:2181
	"EHLO ford.pronto.tv") by vger.kernel.org with ESMTP
	id S262760AbTJJJWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:22:10 -0400
To: linux-kernel@vger.kernel.org
Subject: USB and DMA on Alpha with 2.6.0-test7
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 10 Oct 2003 11:22:06 +0200
Message-ID: <yw1xu16hbg75.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yesterday, I compiled 2.6.0-test7 for one of my Alpha boxes.  I have
an AX8817X based USB ethernet adaptor connected to it (it's short on
PCI slots), so I compiled the usbnet module.  When I loaded usbnet, I
got a BUG at include/asm-generic/dma-mapping.h:19.  Apparently, DMA
setup only works with PCI here.  How should this be fixed?  It worked
with -test4, albeit slowly, for other reasons.

-- 
Måns Rullgård
mru@users.sf.net
