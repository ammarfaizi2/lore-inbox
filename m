Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUG2BIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUG2BIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUG2BIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:08:49 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:40383 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S267397AbUG2BIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:08:14 -0400
Subject: XATTR support
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1091062286.2363.10.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 28 Jul 2004 20:08:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that ext2, ext3, reiserfs, and jfs mark (in menuconfig) their
xattr support as an optional subfeature which is a little surprising
because the xattr support in those filesystems is no longer
experimental/unstable and there seems little harm in just always
building xattr support in to those filesystems.  Now that I have added
xattr support to the cifs filesystem in the cifs development bk tree, I
was planning on making xattr support a suboption (in menuconfig)
following the example of those others, at least at first (the suboption
also would be marked experimental for a while).  

Is there any particular reason to always configure xattr support (not
make it a menuconfig option) for individual filesystems?

