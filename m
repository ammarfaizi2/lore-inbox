Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVCPJxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVCPJxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVCPJxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:53:46 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:33284 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262309AbVCPJxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:53:33 -0500
Message-ID: <423802E6.1020308@aitel.hist.no>
Date: Wed, 16 Mar 2005 10:56:54 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
CC: linux-kernel@vger.kernel.org, dri-devel@lists.sf.net
Subject: Another drm/dri lockup - when moving the mouse
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reported this before, but now I have some more data.

I have an office pc with this video card:
VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 
7000/VE]

In previous reports I found that starting xfree or xorg with dri support
cause a hang after a little while.  It seems that this only happens when
the mouse moves.  Something I didn't discover before because there
are lots of unplanned mouse movements - the thing is sensitive and jumps
a pixel now and then when I move stuff on the desk.

Taking care not to move the mouse, I can start X and run glxgears
with acceleration.  The slightest mouse movement during 3D activity
kills the machine instantly so it only responds to the reset button.  Mouse
movement without 3D activity may or may not kill the pc.

Could there be a problem where 3D-stuff and code to move the mouse
"steps on each other toes" somehow?  Or some way to test this further,
by disabling the mouse or force some kind of software fallback for
the mouse cursor?

Helge Hafting

Helge Hafting



