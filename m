Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUENVtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUENVtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUENVtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:49:23 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:39117 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262954AbUENVtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:49:22 -0400
Date: Fri, 14 May 2004 17:49:19 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: scsi shutdown flush, journaled fses
Message-ID: <20040514214919.GB4360@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <409F4944.4090501@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409F4944.4090501@keyaccess.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so ide drives caching writes is ok now, but what about scsi drives? do
reiserfs and ext3 both use proper write barriers (especially for
data=ordered)?

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
