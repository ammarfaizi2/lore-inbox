Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVCPQpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVCPQpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCPQpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:45:09 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:47339 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262676AbVCPQpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:45:04 -0500
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sf.net
Subject: Re: Another drm/dri lockup - when moving the mouse
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
References: <423802E6.1020308@aitel.hist.no>
Date: Wed, 16 Mar 2005 11:45:03 -0500
In-Reply-To: <423802E6.1020308@aitel.hist.no> (Helge Hafting's message of
 "Wed, 16 Mar 2005 10:56:54 +0100")
Message-ID: <yq1d5tz5yls.fsf@wilson.lab.mkp.net>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Helge" == Helge Hafting <helge.hafting@aitel.hist.no> writes:

Helge> I have reported this before, but now I have some more data.  I
Helge> have an office pc with this video card: VGA compatible
Helge> controller: ATI Technologies Inc Radeon RV100 QY [Radeon
Helge> 7000/VE]

FWIW, I have exactly the same problem with recent (~2.6.9+ or so)
kernels.  PS/2 mouse as well.

(mkp@funky) ~> lspci | grep ATI
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]

Turning off DRI did it for me...

-- 
Martin K. Petersen      http://mkp.net/
