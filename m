Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVGJWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVGJWyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVGJThm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:23955 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262029AbVGJTgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:21 -0400
Date: Sun, 10 Jul 2005 19:36:20 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 72/82] remove linux/version.h from include/linux/istallion.h
Message-ID: <20050710193620.72.PliWpP4181.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

Signed-off-by: Olaf Hering <olh@suse.de>

include/linux/istallion.h |    2 --
1 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/include/linux/istallion.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/linux/istallion.h
+++ linux-2.6.13-rc2-mm1/include/linux/istallion.h
@@ -21,8 +21,6 @@
*	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

-#include <linux/version.h>
-
/*****************************************************************************/
#ifndef	_ISTALLION_H
#define	_ISTALLION_H
