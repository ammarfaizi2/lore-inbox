Return-Path: <linux-kernel-owner+w=401wt.eu-S932403AbWLMBUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWLMBUg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWLMBUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:20:36 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:42875 "EHLO
	liaag1ab.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932403AbWLMBUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:20:36 -0500
Date: Tue, 12 Dec 2006 20:09:36 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: -mm merge plans for 2.6.20
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-ID: <200612122013_MC3-1-D4D6-ABC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061212174909.GD2140@redhat.com>

On Tue, 12 Dec 2006 12:49:09 -0500, Dave Jones wrote:

> EFLAGS: 00010246   (2.6.18-1.2849.fc6 #1) 

> That was from a 2.6.18.3 kernel iirc.

Here's an idea from Michael Tokarev <mjt@tls.msk.ru>:
since .version always contains 1 when you build an RPM,
you can modify it and put your base kernel version there
during the build. Then you would see:

EFLAGS: 00010246   (2.6.18-1.2849.fc6 #2.6.18.3)

-- 
MBTI: IXTP

