Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUHaItg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUHaItg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHaIsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:48:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:35056 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S267526AbUHaIrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:47:42 -0400
Message-ID: <41343B29.4080508@imag.fr>
Date: Tue, 31 Aug 2004 10:47:37 +0200
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: VIA AGPGart problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Tue, 31 Aug 2004 10:47:38 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have encountered problems with the following hardware

Via EPIA M-10000 mini itx

The machine is stable when using either the normal VGA text mode or the 
Frame buffer mode.
However, all hell breaks loose whenever X starts.
The following tests were done :

with agp enabled
run Xorg with the via driver -> X dies after a couple of seconds
run Xorg with frame buffer -> X dies after a minute or so

with agp disabled
run Xorg with the via driver -> X dies after a couple minutes
run Xorg with frame buffer -> machine is useable, but don't push it...

in all the above instances, either X dies without cleaning up after 
itself (and not logging anything useful), yet the machine is available 
through ssh, or, the machine is completely hanged, probability of each 
of those occuring seems related to the phases of the moon...

hope this helps

Raphael
