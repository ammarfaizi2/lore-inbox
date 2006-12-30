Return-Path: <linux-kernel-owner+w=401wt.eu-S1755174AbWL3R1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbWL3R1Q (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 12:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbWL3R1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 12:27:16 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:33011 "EHLO
	liaag2aa.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755180AbWL3R1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 12:27:16 -0500
Date: Sat, 30 Dec 2006 12:21:41 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.19.1
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <200612301224_MC3-1-D6C5-9FCD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200612301659.35982.s0348365@sms.ed.ac.uk>

On Sat, 30 Dec 2006 16:59:35 +0000, Alistair John Strachan wrote:

> I've eliminated 2.6.19.1 as the culprit, and also tried toggling "optimize for 
> size", various debug options. 2.6.19 compiled with GCC 4.1.1 on an Via 
> Nehemiah C3-2 seems to crash in pipe_poll reliably, within approximately 12 
> hours.

Which CPU are you compiling for?  You should try different options.

Can you post disassembly of pipe_poll() for both the one that crashes
and the one that doesn't?  Use 'objdump -D -r fs/pipe.o' so we get the
relocation info and post just the one function from each for now.

-- 
MBTI: IXTP

