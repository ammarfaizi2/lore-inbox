Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264825AbUD1Ovw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbUD1Ovw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264818AbUD1Ovw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:51:52 -0400
Received: from mail.jambit.com ([62.245.207.83]:44305 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S264802AbUD1Ovv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:51:51 -0400
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	linux-kernel@vger.kernel.org<linux-kernel@vger.kernel.org>
						    ^-missing end of address
Date: Wed, 28 Apr 2004 16:50:26 +0200
MIME-Version: 1.0
Subject: remap_file_pages() + MAP_PRIVATE?
Cc: Jamie Lokier <jamie@shareable.org>
Message-ID: <408FE0D2.24249.1C002B2@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

As currently implemented, the mapping given to remap_file_pages() must be 
MAP_SHARED.  Is there some reason why the kernel enforces the restriction 
that we can't apply this call to MAP_PRIVATE mappings?  (I can't see 
one...)  

Cheers,

Michael
