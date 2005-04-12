Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVDLFrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVDLFrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVDLFrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:47:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:30928 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262013AbVDLFfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:35:53 -0400
Date: Mon, 11 Apr 2005 22:35:32 -0700
From: Greg KH <greg@kroah.com>
To: Alex Aizman <itn780@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 2/6] Linux-iSCSI High-Performance Initiator
Message-ID: <20050412053532.GE32372@kroah.com>
References: <425B3F58.2040000@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425B3F58.2040000@yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 08:24:08PM -0700, Alex Aizman wrote:
> +typedef uint64_t iscsi_snx_t;		/* iSCSI Data-Path session handle */
> +typedef uint64_t iscsi_cnx_t;		/* iSCSI Data-Path connection handle */

Do you really have to create a new typedef?  Please reconsider.  Just
use u64 everywhere, unless you need to do type checking...

thanks,

greg k-h
