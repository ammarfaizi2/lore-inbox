Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTFPEbD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 00:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTFPEbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 00:31:03 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:10688 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP id S263319AbTFPEbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 00:31:00 -0400
Message-ID: <3EED4BBD.6090505@snapgear.com>
Date: Mon, 16 Jun 2003 14:46:53 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.71-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Another update of the uClinux (MMU-less) fixups against 2.5.71.
The binfmt_flat load now supports shared libraries for uClinux
style FLAT binaries (forward ported for uClinux-2.4.20). Lots of
little fixups this time too.

You can get it at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.71-uc0.patch.gz


Change log:

. 2.5.71 fixups                                   (me)
. fix argument types in bitops functions          (me)
. binfmt_flat shared library support              (David McCullough)
. cleanup show_process_blocks() for nommu.c       (bernardo Innocenti)


Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com





















