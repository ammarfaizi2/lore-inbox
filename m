Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUJNQIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUJNQIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUJNQIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:08:34 -0400
Received: from clusterfw.beelinegprs.com ([217.118.66.232]:17026 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S266547AbUJNQIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:08:25 -0400
Date: Thu, 14 Oct 2004 20:06:38 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] MS_VERBOSE handling in get_sb_bdev()
Message-ID: <20041014160638.GD25932@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Anybody knows why the "silent" agrument of the fs' ->fill_super() routines is
passed as ((flags & MS_VERBOSE) ? 1 : 0) ?.  It should be !(flags & MS_VERBOSE)
instead, yes?

I don't belive the bug is not known... 

Regards,
Alex.
