Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVCAELg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVCAELg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 23:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCAELg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 23:11:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40635 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261232AbVCAELc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 23:11:32 -0500
Date: Mon, 28 Feb 2005 23:11:27 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Alexander Nyberg <alexn@dsv.su.se>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] SELinux: null dereference in error path
In-Reply-To: <1109637174.3839.13.camel@boxen>
Message-ID: <Xine.LNX.4.44.0502282311190.26032-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005, Alexander Nyberg wrote:

> The 'bad' label will call function that unconditionally dereferences
> the NULL pointer.
> 
> Found by the Coverity tool
> 
> Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

Signed-off-by: James Morris <jmorris@redhat.com>


-- 
James Morris
<jmorris@redhat.com>


