Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUBIPGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 10:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbUBIPGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 10:06:09 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:45798 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S263760AbUBIPGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 10:06:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
In-Reply-To: <20040209115852.GB877@schottelius.org>
References: <20040209115852.GB877@schottelius.org>
Message-Id: <E1AqCz8-0001Wc-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Mon, 09 Feb 2004 15:06:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:

>Looks like at least xfs and reiserfs are not able of handling them,
>as Apache with UTF-8 as default charset delievers wrong names, when
>accessing files with German umlauts.

Are you sure your filenames are in UTF-8 rather than ISO8859-1? If not,
then they'll appear as an invalid UTF-8 string and code that expects
UTF-8 will be unhappy.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
