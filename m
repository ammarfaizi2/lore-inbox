Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbWAHNp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWAHNp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWAHNp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:45:29 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:24752 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932731AbWAHNp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:45:29 -0500
Message-ID: <43C11776.40109@cfl.rr.com>
Date: Sun, 08 Jan 2006 08:45:26 -0500
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SG_GET_ACCESS_COUNT ioctl problem
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.4 kernel (not using devfs) the SG_GET_ACCESS_COUNT ioctl to an
sg device would report the correct/expected usage count when issued to a
sd disc that was mounted, accounting for the mount by the system. The
2.6 kernel does not. Is this now the expected behavior or is this a bug?

Mark
