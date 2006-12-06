Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937821AbWLFX4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937821AbWLFX4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937823AbWLFX4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:56:41 -0500
Received: from europa.lunarpages.com ([209.200.229.75]:38165 "EHLO
	europa.lunarpages.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937821AbWLFX4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:56:40 -0500
Subject: Obtaining a list of memory address ranges allocated to processes
From: Stephen Torri <storri@torri.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 17:56:26 -0600
Message-Id: <1165449386.13079.30.camel@base.torri.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - europa.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - torri.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to create a custom ELF and Windows PE loader for the purpose
of security research. I am having a difficult time finding how to
allocate memory for a binary at the desired address in memory
(especially if its non-relocatable). I would like to see why I cannot
get memory allocated at the exact address request in the binary headers.
Is there a program or system call that allows me to see a list of memory
address ranges allocated to the running processes on a system?

Stephen

