Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbUCOWP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUCOWP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:15:26 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:55444 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262786AbUCOWPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:15:18 -0500
Message-ID: <40562AEC.9080509@us.ibm.com>
Date: Mon, 15 Mar 2004 14:15:08 -0800
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: DRM reorganization
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're looking at reorganizing the way DRM drivers are maintained. 
Currently, the DRM kernel code lives deep in a subdirectory of the DRI 
tree (which is a partial copy of the XFree86 tree).  We plan to move it 
"up" to its own module at the top level.  That should make it *much* 
easier for people that want to do things with the DRM but don't want all 
the rest of X (i.e., DRI w/DirectFB, etc.).

When we do this move, we're open to the possibility of reorganizing the 
file structure.  What can we do to make it easier for kernel release 
maintainers to merge changes into their trees?

This is cross-posted to LKML & dri-devel, and I'm not on LKML.  If you 
reply, please hit the 'Reply to all' button. :)


