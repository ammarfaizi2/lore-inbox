Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCZRwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCZRwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 12:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVCZRwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 12:52:30 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:38665 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261197AbVCZRw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 12:52:26 -0500
Date: Sat, 26 Mar 2005 17:52:20 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
I have found that I can't use SYSFS on Linux-2.6.10.

Why ?. 

I am not modifing the Kernel/SYSFS code so I should be able, to use all
the SYSFS/internal kernel function calls without hinderence.

In order to be able to use SYSFS to debug the driver during development
the way I would like to be able to do, I will have to temporally change
the module licence line to "GPL". When the development is finnished I will
then need to remove all the code that accesses the SYSFS stuf in the
Kernel and change the module back to a "Proprietry" licence in order to
comply with other requirements. This will then hinder any debugging if
future issues arise.

I believe that this sort of idiocy is what helps Microsoft hold on to its
manopoly and as shuch hinders hardware/software development in all areas
and should be chanaged in a way that promotes diversified software
development.

Regards
	Mark Fortescue.





