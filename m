Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTJJQl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTJJQl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:41:58 -0400
Received: from main.gmane.org ([80.91.224.249]:37289 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263098AbTJJQl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:41:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Date: Fri, 10 Oct 2003 18:41:53 +0200
Message-ID: <yw1xllrtavu6.fsf@users.sourceforge.net>
References: <yw1xu16hbg75.fsf@users.sourceforge.net> <20031010144710.A1396@jurassic.park.msu.ru>
 <20031010133104.GE28224@mail.shareable.org>
 <20031010174109.A12022@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:868iy4hTBLAPfrbUcjXQbWU2ag8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

>> Isn't the device's dma_mask set equal to the controller's dma_mask
>> automatically?
>
> You are right, just check dma_mask of the device.
>
> Anyway, as it is, usbnet driver won't work on i386 with
> more than 4G of RAM and 32-bit DMA USB controller.

So, what should the patch look like?  I'd like to use this thing.

-- 
Måns Rullgård
mru@users.sf.net

