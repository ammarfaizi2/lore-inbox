Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVCAPM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVCAPM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVCAPM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:12:56 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:64657 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261934AbVCAPMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:12:53 -0500
Subject: Re: [PATCH] SELinux: null dereference in error path
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jmorris@redhat.com
In-Reply-To: <1109637174.3839.13.camel@boxen>
References: <1109637174.3839.13.camel@boxen>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 01 Mar 2005 10:05:10 -0500
Message-Id: <1109689510.10589.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 01:32 +0100, Alexander Nyberg wrote:
> The 'bad' label will call function that unconditionally dereferences
> the NULL pointer.
> 
> Found by the Coverity tool
> 
> Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

