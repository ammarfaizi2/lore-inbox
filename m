Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTEFNyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbTEFNx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:53:58 -0400
Received: from rth.ninka.net ([216.101.162.244]:52176 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263745AbTEFNxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:53:00 -0400
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: "David S. Miller" <davem@redhat.com>
To: Thomas Horsten <thomas@horsten.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0305061034030.8287-100000@jehova.dsm.dk>
References: <Pine.LNX.4.40.0305061034030.8287-100000@jehova.dsm.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052212765.983.18.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 02:19:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 02:16, Thomas Horsten wrote:
> The following patch fixes the problem:

Making the u64 swabbing functions unavailable is not an
acceptable solution.

-- 
David S. Miller <davem@redhat.com>
