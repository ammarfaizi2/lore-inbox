Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVHWN3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVHWN3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVHWN3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:29:16 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:42355 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932169AbVHWN3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:29:15 -0400
Date: Tue, 23 Aug 2005 15:29:14 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what does scsi sense means?
Message-ID: <20050823132914.GB29062@harddisk-recovery.com>
References: <7cd5d4b4050823020772cc5c9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd5d4b4050823020772cc5c9e@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 05:07:12PM +0800, jeff shia wrote:
> in the file of aic7xxxx.c ,what is the function of the structure of
> scsi_sense?here what is the meaning of  sense?just like probe?

Return "value" of a failed command. Normally commands just succeed, but
if it fails, you can get "sense information" which tells you more about
why a particular command failed.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
