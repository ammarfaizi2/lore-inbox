Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUDPSN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDPSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:11:37 -0400
Received: from hermes.domdv.de ([193.102.202.1]:52746 "EHLO zeus.lan.domdv.de")
	by vger.kernel.org with ESMTP id S263567AbUDPSHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:07:44 -0400
Message-ID: <408020E2.9060900@domdv.de>
Date: Fri, 16 Apr 2004 20:07:30 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040311
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make stack executable on demand?
References: <20040416170915.GA20260@lucon.org>
In-Reply-To: <20040416170915.GA20260@lucon.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:
> is set with executable stack. Is there a third option that a process
> starts with non-executable stack and can change the stack permission
> later?
> 

Well, in my opinion your request is equivalent to "keep all these cute 
buffer overflows forever". Take any protected app, LD_PRELOAD or drop in 
a bad/malicious library and your're done for good. Not really a good idea.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
