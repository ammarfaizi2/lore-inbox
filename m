Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271116AbTGQRbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271340AbTGQRbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:31:39 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:42247 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271116AbTGQRbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:31:38 -0400
Date: Thu, 17 Jul 2003 18:46:32 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Patrick Plattes <patrick@erdbeere.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: rivafb problem (2.6.0-test1)
In-Reply-To: <20030717163326.GA333@erdbeere.net>
Message-ID: <Pine.LNX.4.44.0307171843421.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> actually i have cursor - it looks like an underlined 'P'. if i try to
> switch to an other hsync changed to 120hz. 

Its a bug in the cursor code. I have been working on it for the last few 
days.

> if i try to use x it works
> fine (ok, i can't switch back to the console).

That is not fine. Did you add Option "UseFBDev" to your XF86Config. That 
should help with that problem.

