Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWF3AD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWF3AD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWF3AD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:03:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:9168 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751331AbWF3AD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:03:26 -0400
Date: Thu, 29 Jun 2006 16:57:28 -0700
From: Greg KH <gregkh@suse.de>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] SELinux: Update USB code with new kill_proc_info_as_uid
Message-ID: <20060629235728.GB7546@suse.de>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei> <Pine.LNX.4.64.0606281946561.17159@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606281946561.17159@d.namei>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 07:49:09PM -0400, James Morris wrote:
> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch updates the USB core to save and pass the sending task secid 
> when sending signals upon AIO completion so that proper security checking 
> can be applied by security modules.
> 
> Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
> Signed-off-by: James Morris <jmorris@namei.org>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
