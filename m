Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264529AbTCZFOs>; Wed, 26 Mar 2003 00:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbTCZFOs>; Wed, 26 Mar 2003 00:14:48 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:44677 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264529AbTCZFOr>; Wed, 26 Mar 2003 00:14:47 -0500
Message-Id: <200303260525.h2Q5PulK314364@pimout2-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sleeping function called from illegal context at mm/slab.c:1723
Date: Tue, 25 Mar 2003 13:05:10 +0100
X-Mailer: KMail [version 1.3.2]
References: <200303251501.22938.schlicht@uni-mannheim.de>
In-Reply-To: <200303251501.22938.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 March 2003 03:01 pm, Thomas Schlichter wrote:
> Every second I get following Debug message with kernel 2.5.66:
>
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:

Yes.  This is a known bug in the frame buffer driver.  James Simmons is 
working on a fix for this.

regards,
dan carpenter

