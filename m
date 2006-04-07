Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWDGTZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWDGTZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWDGTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:25:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54416 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964907AbWDGTZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:25:39 -0400
Date: Fri, 7 Apr 2006 14:25:31 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, "Eric W. Biederman" <ebiederm@xmission.com>,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 2/5] uts namespaces: Switch to using uts namespaces
Message-ID: <20060407192531.GD28729@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.D025B19B8FF@sergelap.hallyn.com> <20060407191742.GD9097@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407191742.GD9097@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Ravnborg (sam@ravnborg.org):
> On Fri, Apr 07, 2006 at 01:36:00PM -0500, Serge E. Hallyn wrote:
> > Replace references to system_utsname to the per-process uts namespace
> > where appropriate.  This includes things like uname.
> If you define helpers that operates on system_utsname and then apply
> this patch the kernel will still compile, and only later you can
> introduce the new stuff.

Ok, will try structuring the patches that way.

thanks,
-serge
