Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTH0LIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTH0LIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:08:36 -0400
Received: from ns.suse.de ([195.135.220.2]:51680 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263348AbTH0LIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:08:31 -0400
Subject: Re: [Acl-Devel] [NFS] [PATCH] Stop call_decode() from ignorning
	RPC header errrors
From: Andreas Gruenbacher <agruen@suse.de>
To: Steve Dickson <SteveD@redhat.com>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>,
       acl-devel@bestbits.at
In-Reply-To: <3F43B13C.5010403@RedHat.com>
References: <3F43B13C.5010403@RedHat.com>
Content-Type: text/plain
Organization: SuSE Labs, SuSE Linux AG
Message-Id: <1061982510.1492.6.camel@chaos.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Aug 2003 13:08:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

thanks a lot for the patch. It helps.


On Wed, 2003-08-20 at 19:34, Steve Dickson wrote:
> This patch stop call_decode() from ignoring errors
> that are found while parsing the RPC header. I turns
> out the nfs acls routines need these error codes to do
> the right thing...
> 
> SteveD.


