Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbTHYJCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbTHYJCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:02:22 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:38333
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261496AbTHYJCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:02:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Orthogonal Interactivity Patches
Date: Mon, 25 Aug 2003 19:09:16 +1000
User-Agent: KMail/1.5.3
References: <200308251322.12050.kernel@kolivas.org>
In-Reply-To: <200308251322.12050.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308251909.16932.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Addendum

On Mon, 25 Aug 2003 13:22, Con Kolivas wrote:
> default scheduler. The remaining issue is that application startup will be
> slower than the vanilla scheduler (your mileage may vary) under load, but I
> feel not unacceptably so as a tradeoff. 

I'm experimenting with a kind of central tendency with tasks that have not yet 
declared themselves high or low credit by weighting down the cpu run time 
when their credit is neither high nor low. Hopefully this can speed up 
application startup under load without too much general slowdown by current 
cpu hogs.

Con

