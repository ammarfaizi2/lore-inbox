Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270585AbRIFMqq>; Thu, 6 Sep 2001 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270523AbRIFMqh>; Thu, 6 Sep 2001 08:46:37 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:35936 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S270585AbRIFMqS>; Thu, 6 Sep 2001 08:46:18 -0400
Date: Thu, 6 Sep 2001 07:46:37 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200109061246.HAA61789@tomcat.admin.navo.hpc.mil>
To: kubla@sciobyte.de, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
Cc: joe@mathewson.co.uk, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla <kubla@sciobyte.de>:
On Wed, Sep 05, 2001 at 05:12:48PM -0500, Jesse Pollard wrote:
> 
> Kerberos won't help either - The only parts of NFS that were kerberized
> was the initial mount. Everything else uses filehandles/UDP. Encryption
> doesn't help either - slows the entire network down too much.

I disagree! First of all you can always use NFS over TCP, so much for
"every thing else uses filehandles/UDP". (No that this improves security,
but it can improve reliability!)

Yes - but it won't work in the environment. As you pointed out, it works
under Solaris. No MACs, No Linux, and no MS windows (which would likely be
present in a lab).

Second, without physical security you can't protect the access keys - hence
no kerberos.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
