Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbUKJBcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUKJBcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUKJBcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:32:53 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:25741 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S261824AbUKJBck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:32:40 -0500
Date: Wed, 10 Nov 2004 02:32:35 +0100
To: linux-kernel@vger.kernel.org
Subject: Ideas for a new io scheduler for desktop
Message-ID: <20041110013235.GA13691@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I think that a new io-scheduler that gave priority to bursty access to
block devices would be interesting for desktop and workstation use, and
even for some servers.

I'm often waiting for graphical aplications, vim, mutt, and almost every
program to which I have to interact with because they are blocked
waiting for just a few blocks of IO that won't get served fast just
because there's a single process hog that's provoking that high latency.

In network terminology the disk just feel like a network interface without QoS, 
service time just goes up insanely with just one client in the queue.

Although much care should be taken in designing this algorithm to
prevent unfairness, I believe there's room for improvement in this area.

I'd like to read about your opinions.

Regards.
-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
	* Las patentes de programación son nocivas para la innovación * 
				http://proinnova.hispalinux.es/
