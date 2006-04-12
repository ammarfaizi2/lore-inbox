Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWDLFB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWDLFB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWDLFB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:01:26 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:37603 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751014AbWDLFBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:01:25 -0400
Date: Wed, 12 Apr 2006 00:01:23 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sam Vilain <sam@vilain.net>
Cc: Kirill Korotaev <dev@sw.ru>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 2/5] uts namespaces: Switch to using uts namespaces
Message-ID: <20060412050123.GA7743@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.D025B19B8FF@sergelap.hallyn.com> <443BA062.1040208@sw.ru> <443C19C6.80706@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443C19C6.80706@vilain.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Vilain (sam@vilain.net):
> Kirill Korotaev wrote:
> 
> >Serge,
> >
> >BTW, have you noticed that NFS is using utsname for internal processes 
> >and in general case this makes NFS ns to be coupled with uts ns?
> >  
> >
> 
> Either that, or each NFS vfsmount has a uts_ns pointer.

Sorry, I must be being dense.  I only see utsname being used in the case
of nfsroot.  Can you point me to where you're talking about?

thanks,
-serge
