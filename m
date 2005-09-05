Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVIEQii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVIEQii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVIEQih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:38:37 -0400
Received: from [81.2.110.250] ([81.2.110.250]:64994 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932341AbVIEQih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:38:37 -0400
Subject: Re: DVD+-R[W] regression in 2.6.12/13
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Oliver Tennert <O.Tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <431C7131.3030506@rtr.ca>
References: <200509051533.01465.tennert@science-computing.de>
	 <431C7131.3030506@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Sep 2005 18:02:51 +0100
Message-Id: <1125939771.8714.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-05 at 12:24 -0400, Mark Lord wrote:
> I'm not sure why the "failed: Input/output error" (-EIO) result is
> being returned from the ATA layer in this case.  Driver bug, most likely.

Because the command failed an error was reported back instead of success
status/info.

Alan

