Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUI2WXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUI2WXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUI2WWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:22:33 -0400
Received: from open.hands.com ([195.224.53.39]:44171 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269183AbUI2WTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:19:02 -0400
Date: Wed, 29 Sep 2004 23:30:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: sys_* in fs/*.c - need most of it for fsproxy module!
Message-ID: <20040929223008.GA6125@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm writing an fsproxy module.

so far i have pretty much cut/paste the entire contents of the following
functions - unmodified - into the fsproxy module (based on fuse).

any modifications, if any, are to strip out the top of the function
which does the conversion from userspace memory to kernel memory.

example: i'm just about to cut/paste the entire contents of
sys_unlink... minus the calls to getname and putname.

does anyone have any objections to me creating a patch which would
make the code in sys_unlink, sys_rename, sys_link, sys_this, sys_that,
available from inside the kernel?

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

