Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTEFAmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTEFAmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:42:21 -0400
Received: from zero.aec.at ([193.170.194.10]:52743 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262237AbTEFAmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:42:20 -0400
Date: Tue, 6 May 2003 02:53:26 +0200
From: Andi Kleen <ak@muc.de>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Adrian Bunk <bunk@fs.tum.de>, lkml <linux-kernel@vger.kernel.org>,
       ak@muc.de, ingo.oeser@informatik.tu-chemnitz.de
Subject: Re: 2.5.68-bk11: .text.exit errors in .altinstructions
Message-ID: <20030506005326.GB18146@averell>
References: <20030502171355.GU21168@fs.tum.de> <1052175893.25085.9.camel@nalesnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052175893.25085.9.camel@nalesnik>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 01:04:55AM +0200, Grzegorz Jaskiewicz wrote:
> I've got the same problem with 2.5.69:

Use the same workaround. Remove .text.exit from the DISCARD
section in your vmlinux.lds.S

Really the problem is unfixable without binutils changes in other
ways, sorry.

-Andi
