Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUC2JuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 04:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUC2JuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 04:50:12 -0500
Received: from smtp1.freeserve.com ([193.252.22.158]:27386 "EHLO
	mwinf3001.me.freeserve.com") by vger.kernel.org with ESMTP
	id S262429AbUC2JuJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 04:50:09 -0500
Message-ID: <5625455.1080553808079.JavaMail.www@wwinf3002>
From: tigran@aivazian.fsnet.co.uk
Reply-To: tigran@aivazian.fsnet.co.uk
To: lml@beonline.com.au
Subject: Re: Kernel / Userspace Data Transfer
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [62.172.234.2]
Date: Mon, 29 Mar 2004 11:50:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

One possible solution is to use seq_file API for a /proc file.
I have written a process/system monitor using this method which is about 100
times faster than reading various bits and pieces from /proc by a user application,
so a kernel module is well worth having in this respect. Unfortunately, this software
is not under GPL, but if you do want more information I can send you (or upload
somewhere) a stripped down version which just shows how to use the API
most efficiently and safely.

Kind regards
Tigran
Freeserve AnyTime - HALF PRICE for the first 3 months - Save £7.50 a month 
www.freeserve.com/anytime
