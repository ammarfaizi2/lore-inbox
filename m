Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWAQQPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWAQQPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWAQQPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:15:44 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:2459 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751308AbWAQQPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:15:44 -0500
Date: Tue, 17 Jan 2006 09:15:43 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: PID virtualisation snafu
Message-ID: <20060117161543.GJ19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there any web archives of l-k that give out the email address of
the author?

I can tell the author of the virtualisation patches hasn't even tried to
compile them.  Here's one example:

- host->host_no, tmp->pid, tmp->device->id, tmp->device->lun, tmp->result);
+ host->host_no, tmtask_pid(p), tmp->device->id, tmp->device->lun, tmp->result);

