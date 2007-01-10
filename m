Return-Path: <linux-kernel-owner+w=401wt.eu-S964932AbXAJSbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbXAJSbY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbXAJSbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:31:23 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:9143 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932AbXAJSbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:31:23 -0500
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] guest crash on 2.6.20-rc4
X-Message-Flag: Warning: May contain useful information
References: <ada4pr1mqz2.fsf@cisco.com> <45A40898.4040307@qumranet.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 Jan 2007 10:31:11 -0800
In-Reply-To: <45A40898.4040307@qumranet.com> (Avi Kivity's message of "Tue, 09 Jan 2007 23:26:48 +0200")
Message-ID: <adairfe20pc.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Jan 2007 18:31:12.0107 (UTC) FILETIME=[8113EBB0:01C734E5]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I've managed to reproduce a bug with similar characteristics: a write
 > fault into a present, writable kernel page.  The attached patch should
 > fix it.

Sorry for the delay in continuing this thread.  Anyway, the oops seems
to be pretty reproducible by running the makewhatis and locate db
update scripts in a loop.  I've applied your patch and kicked off a
test run;  I'll let you know if I can still get the bug to happen.

Thanks
