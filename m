Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbVIPPXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbVIPPXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbVIPPXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:23:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64128 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161131AbVIPPXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:23:53 -0400
Date: Fri, 16 Sep 2005 11:23:33 -0400
From: Alan Cox <alan@redhat.com>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: akpm@osdl.org, alan@redhat.com, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.14-rc1] PR_GET_DUMPABLE returns incorrect info
Message-ID: <20050916152333.GA24455@devserv.devel.redhat.com>
References: <18739.1126883736@www47.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18739.1126883736@www47.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 05:15:36PM +0200, Michael Kerrisk wrote:
> I suggest the following small patch.  Perhaps Alan has comments.

When it went into 2.4-ac I didnt want to expose a value to the user space that
wasn't in the upstream kernel as this was all done for RHEL3 originally.

The change makes total sense to me

