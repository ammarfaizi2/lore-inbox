Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTL2Dzy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTL2Dzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:55:54 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:20960 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262598AbTL2Dzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:55:54 -0500
Date: Sun, 28 Dec 2003 19:55:33 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: akmiller@nzol.net, linux-kernel@vger.kernel.org
Subject: Re: ide: "lost interrupt" with 2.6.0
Message-ID: <20031229035533.GG1882@matchmail.com>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>, akmiller@nzol.net,
	linux-kernel@vger.kernel.org
References: <1072657930.3fef760a50062@webmail.nzol.net> <Pine.LNX.4.10.10312281934150.32122-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10312281934150.32122-100000@master.linux-ide.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 07:37:37PM -0800, Andre Hedrick wrote:
> I know the FSM's are wrong because I fixed them for Dupli-Disk.
> How they operate, I can not disclose.  But Accusys can not handle correct
> settings for FSM to Taskfile.

Does that mean that if you use taskfile on Dupli-Disk controllers that they
will fail, and that disabling taskfile access might help (is that still an
option in 2.6?)

