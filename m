Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVCILKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVCILKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCILKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:10:52 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:22407 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S261606AbVCILKm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:10:42 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
To: linux-kernel@vger.kernel.org
Subject: Max size of writing to the proc file system
Date: Wed, 9 Mar 2005 12:10:39 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503091210.40115.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

What is the maximal data I can write to a /proc file? I write two kilo bytes, 
but buffer in the proc_write function only contains 1003 bytes :-((

Cheers, Kristian.

-- 
Kristian Sørensen
- The Umbrella Project  --  Security for Consumer Electronics
  http://umbrella.sourceforge.net
