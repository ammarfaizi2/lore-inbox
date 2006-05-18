Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWERXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWERXDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWERXDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:03:19 -0400
Received: from ozlabs.org ([203.10.76.45]:23976 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751142AbWERXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:03:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17516.64814.419031.437216@cargo.ozlabs.ibm.com>
Date: Fri, 19 May 2006 09:03:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 8/9] namespaces: utsname: remove system_utsname
In-Reply-To: <20060518155054.GI28344@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518155054.GI28344@sergelap.austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn writes:

> The system_utsname isn't needed now that kernel/sysctl.c is fixed.
> Nuke it.

You don't seem to have grepped for existing uses of system_utsname, of
which there are a bunch under arch/powerpc at least...

Paul.
