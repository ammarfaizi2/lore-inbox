Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUGJPVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUGJPVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUGJPVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:21:49 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:9681 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S266287AbUGJPVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:21:35 -0400
Date: Sat, 10 Jul 2004 17:21:25 +0200
From: Antonin Kral <A.Kral@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Fatal problem, possibly related to AIC79xx
Message-ID: <20040710152125.GD21718@sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://www.bobek.cz
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to install Linux (in particular Debian) to our new servers.
These servers are based od motherbard SuperMicro X5DL8-GG with aic7902
without RAID, 1GB RAM, one XEON 3.06GHz

I have two, really strange problems, first of all I have noticed, that
with enabled SMP support kernel detects TWO processors, but only one is
physically installed.

The second problem is, that I am not able to run almost any program.
E.g. if I try to execute free I'll get "Illegal instruction", for mount
I'll get "Segmentation Fault".

What I've tried:

  Vanilla kernels 2.4.25, 2.4.26, 2.6.6, 2.6.7. And almost all
combinations with/without:
          * SMP
          * APIC
          * Highmem
          * MTRR

All without ACPI and with aic79xx and e1000 build in kernel.

  I've tried Knoppix 3.4. The strange think was that I was unable to
load module for aic79xx, because of "no such device".

Does anyone have any idea how to solve my problems?

  Thank you, best regards,

        Antonin Kral

