Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbUAGSGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUAGSDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:03:49 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:19903 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S266297AbUAGSAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:00:25 -0500
Date: Wed, 7 Jan 2004 10:00:01 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS over 7.7TB LVM partition through NFS
Message-ID: <20040107180001.GM1882@matchmail.com>
Mail-Followup-To: Jirka Kosina <jikos@jikos.cz>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 06:36:49PM +0100, Jirka Kosina wrote:
> Hi,
> 
> I am experiencing problems with LVM2 XFS partition in 2.6.0 being accessed 
> over NFS. After exporting the filesystem clients start writing files to 
> this partition over NFS, and after a short while we get this call trace, 
> repeating indefinitely on the screen and the machine stops responding 
> (keyboard, network):
> 
> Jan  8 01:40:28 storage2 kernel: Call Trace:

You left out the headers with all of the register value information,
especially EIP...
