Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDSRwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDSRwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWDSRwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:52:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61650 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750822AbWDSRwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:52:34 -0400
Date: Wed, 19 Apr 2006 12:51:23 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
Message-ID: <20060419175123.GD1238@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Kirill Korotaev <dev@sw.ru> writes:
> 
> > Serge,
> >
> > can we do nothing with sysctls at this moment, instead of commiting hacks?
> 
> Except that we modify a static table changing the uts behaviour in
> proc_doutsstring isn't all that bad.
> 
> I'm just about to start on something more comprehensive, in
> the sysctl case.

So assuming that I take out the switch(), leaving that for a better
solution by Eric (or Dave, or whoever),

Is it time to ask for the utsname namespace patch to be tried out
in -mm?

thanks,
-serge
