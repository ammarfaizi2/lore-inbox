Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbUAGBP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 20:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbUAGBP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 20:15:28 -0500
Received: from cpc1-cosh4-5-0-cust84.cos2.cable.ntl.com ([81.96.30.84]:24470
	"EHLO slut.local.munted.org.uk") by vger.kernel.org with ESMTP
	id S266109AbUAGBP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 20:15:28 -0500
Date: Wed, 7 Jan 2004 01:15:25 +0000 (GMT)
From: Alex Buell <alex.buell@munted.org.uk>
X-X-Sender: alex@slut.local.munted.org.uk
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: /proc/slabinfo reports excessive size-64 objects
Message-ID: <Pine.LNX.4.58.0401070111250.27290@slut.local.munted.org.uk>
X-no-archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both of my 2.4.23 boxes reports excessive size-64 objects 

1) on my 512MB box, it's  3176370 3176442     64 53838 53838    1 
2) on my 128MB box, it's  1223329 1223365     64 20735 20735	1

Is this really normal? Both boxes have been up for 2 days, but the 128MB
box is starting to show signs of getting slower and slower the more the
size-64 cache increases.

-- 
http://www.munted.org.uk

Your mother cooks socks in hell
