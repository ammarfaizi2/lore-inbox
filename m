Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbSKFVx4>; Wed, 6 Nov 2002 16:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266139AbSKFVxz>; Wed, 6 Nov 2002 16:53:55 -0500
Received: from email.careercast.com ([216.39.101.233]:38872 "HELO
	email.careercast.com") by vger.kernel.org with SMTP
	id <S266135AbSKFVxZ>; Wed, 6 Nov 2002 16:53:25 -0500
Subject: build kernel for server farm
From: Matt Simonsen <matt_lists@careercast.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 14:00:08 -0800
Message-Id: <1036620009.1332.12.camel@mattsworkstation>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am pretty familiar with the build process and kernel install for a
single Linux box, but I wanted to confirm I'm doing things in a sane way
for a large deployment. All the machines are the same hardware and
running standard setups.

First, I plan on compiling the kernel on a development box. From there
my plan is basically tar /usr/src/linux, copy to each box, untar, copy
bzImage and System.map to /boot, run make modules_install, edit
lilo.conf, run lilo.

Tips? Comments?

Thanks 
Matt

