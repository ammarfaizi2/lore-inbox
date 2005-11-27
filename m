Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVK0Tv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVK0Tv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVK0Tv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:51:26 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:8543 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbVK0TvZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:51:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MS5ivmqBsl8HXIRij+D3hDq59EixqlJQG7UmloNTzTfxq0YaEKElbNVRbUaAPBCv7IDDFTZ5NOSzn8guDKJnKFSxgGZWYzQlPZuflqumDdyZsm3wVx4nF173UyUGHNcguwWPPb7qnD3MwtPANIEgqD2vBoNZfEI+2prjoDgBLHQ=
Message-ID: <28d495d10511271151lcac4998w292dff6e677130bc@mail.gmail.com>
Date: Sun, 27 Nov 2005 20:51:25 +0100
From: Frederik <freggy@gmail.com>
To: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: 2.6.15-rc2-ck2 with adaptive readahead: processes stuck in D state
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I compiled 2.6.15-rc2-ck2 kernel with adaptive readahead patch
v.8. The system is running Mandriva Cooker. With this kernel, it
occured two times to me, that urpmi --auto-select starts hanging, and
ps shows several processes stuck in D state (such as ldconfig).

I am using XFS for all file systems, I'm wondering if it is related to
this, because I see several XFS methods mentioned in the trace.

I have put dmesg, config and the trace online on
http://users.telenet.be/fhimpe/kernelbug/
