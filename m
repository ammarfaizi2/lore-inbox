Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVCHREc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVCHREc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVCHREc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:04:32 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:48520 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261235AbVCHREa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:04:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=JhReJRGmBv8ey8wMH7T4Yuhda/IOsW/YmUb6+GXO1az9IsExdxz4kVYms8hF63kVcz4aYW3sxGu+c924aYSEBGBrECdRa9OIYRQos6VPwjfHUdP9cHeDpu9w6PfkBL/tXaQK7lBgi/haznv3OhAr4XF5aWnTXW/HCOsqVNUUVNs=
Message-ID: <c26b959205030809044364b923@mail.gmail.com>
Date: Tue, 8 Mar 2005 22:34:27 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
Reply-To: Imanpreet Arora <imanpreet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question regarding thread_struct
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
	I am wondering if someone could provide information as to how
thread_struct is kept in memory. Robert Love mentions that it is kept
at the "lowest"  kernel address in case of x86 based platform. Could
anyone answer these questions.

a)	When a stack is resized, is the thread_struct structure copied onto
a new place?
b)	What is the advantage of this scheme as against a fixed "virtual-address"?
c)	Also could you kindly point the relevant files which do all this
stuff "shed.c"(?)


TIA

-- 

Imanpreet Singh Arora
