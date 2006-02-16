Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWBPU5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWBPU5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBPU5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:57:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:13760 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S964899AbWBPU5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:57:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate the tasklist_lock export
References: <20060215130734.GA5590@lst.de>
Organization: private Linux site, southern Germany
From: Olaf Titz <olaf@bigred.inka.de>
Date: Thu, 16 Feb 2006 21:50:30 +0100
Message-ID: <E1F9q58-0001yZ-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20060215130734.GA5590@lst.de> you write:
> Drivers have no business looking at the task list and thus using this
> lock.  The only possibly modular users left are:

CIPE is a driver which consists of a kernel module and a userspace
program, where each one of possibly many kernel devices is associated
with exactly one userspace process, and it uses the task list to keep
track of these associations. Is there a recommended other way to
handle such a situation?

Olaf

