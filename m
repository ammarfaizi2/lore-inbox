Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTFAUVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbTFAUVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:21:21 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:23814 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S264722AbTFAUVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:21:21 -0400
Date: Sun, 01 Jun 2003 14:34:40 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Willy Tarreau <willy@w.ods.org>,
       Daniel Podlejski <underley@underley.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx problem
Message-ID: <2859720000.1054499680@aslan.scsiguy.com>
In-Reply-To: <20030601083656.GI21673@alpha.home.local>
References: <20030531165945.GA5561@witch.underley.eu.org> <20030601083656.GI21673@alpha.home.local>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm that makes quite a difference ! I didn't understand what happened between
> these two outputs. Also, did you try with Justin's latest version of the driver:
> 

My driver can't fix interrupt routing issues which is what Daniel's
problem turned out to be.  I'm really tempted to add an interrupt
test to the driver attach so that these kinds of problems are clearly
flagged and my driver doesn't continue to get blamed for interrupt
routing it can't control.

--
Justin

