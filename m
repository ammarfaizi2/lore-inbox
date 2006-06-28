Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWF1QD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWF1QD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWF1QD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:03:58 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:26791 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751231AbWF1QDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:03:52 -0400
Date: Wed, 28 Jun 2006 17:03:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SELinux/MIPS: Add security hooks to mips-mt {get,set}affinity
Message-ID: <20060628160348.GA27175@linux-mips.org>
References: <Pine.LNX.4.64.0606280934080.12338@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606280934080.12338@d.namei>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 09:36:46AM -0400, James Morris wrote:

> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch adds LSM hooks into the setaffinity and getaffinity functions 
> for the mips architecture to enable security modules to control these 
> operations between tasks with different security attributes. This 
> implementation uses the existing task_setscheduler and task_getscheduler 
> LSM hooks.

Thanks, applied.

  Ralf
