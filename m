Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263474AbUJ3CW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263474AbUJ3CW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbUJ3CUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 22:20:07 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:28569 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S263467AbUJ3CTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 22:19:55 -0400
Message-ID: <4182FA3D.1090108@esoterica.pt>
Date: Sat, 30 Oct 2004 03:19:41 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041005
X-Accept-Language: pt, pt-br
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: k 2.6.9: ub module causes /dev/sda and /dev/sda1 not being created
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had problems with my pen drive.
Module ub (autolodaded) recognized the pendrive. So /dev/sda
and /dev/sda1 didn't get created. After removing ub module
from kernel config I could mount the pen drive as /dev/sda1.

