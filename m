Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVCNFov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVCNFov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVCNFov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:44:51 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:37129 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261479AbVCNFos
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:44:48 -0500
Message-ID: <423524C1.808@snapgear.com>
Date: Mon, 14 Mar 2005 15:44:33 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.11-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.11.

Most new changes center around the recent nommu changes to keep
the mm list as a vma list. Still a bunch of old changes I need
to push up stream in this patch too.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.11-uc0.patch.gz


Change log:

. import of linux-2.6.11                       <gerg@snapgear.com>
. change vma list setup for nommu              <gerg@snapgear.com>
. fix MAGIC_ROMPTR nommu support               <gerg@snapgear.com>
. remove unused semp3.h                        <domen@coderock.org>


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com


