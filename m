Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTLXUd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLXUd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 15:33:56 -0500
Received: from dukat.upl.cs.wisc.edu ([128.105.45.39]:49869 "EHLO
	dukat.upl.cs.wisc.edu") by vger.kernel.org with ESMTP
	id S262731AbTLXUdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 15:33:55 -0500
Date: Wed, 24 Dec 2003 14:33:54 -0600 (CST)
From: Ben Srour <srour@cs.wisc.edu>
X-X-Sender: srour@data.upl.cs.wisc.edu
To: linux-kernel@vger.kernel.org
Subject: Safe ISA port probing?
In-Reply-To: <20031224200433.GC6577@kroah.com>
Message-ID: <Pine.LNX.4.44.0312241431280.2726-100000@data.upl.cs.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

What is the safest way to go about probing for non-pnp ISA devices on a
system?

Is the only solution to start at a base address and increment until you
find something interesting? Won't this put devices along the way in an
unsafe state?

Any advice/suggestions would be appreciated,

Thanks
Ben

-- 
Ben Srour
srour@cs.wisc.edu

