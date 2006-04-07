Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWDGTRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWDGTRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWDGTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:17:52 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:3086 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964896AbWDGTRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:17:51 -0400
Date: Fri, 7 Apr 2006 21:17:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 2/5] uts namespaces: Switch to using uts namespaces
Message-ID: <20060407191742.GD9097@mars.ravnborg.org>
References: <20060407095132.455784000@sergelap> <20060407183600.D025B19B8FF@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407183600.D025B19B8FF@sergelap.hallyn.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 01:36:00PM -0500, Serge E. Hallyn wrote:
> Replace references to system_utsname to the per-process uts namespace
> where appropriate.  This includes things like uname.
If you define helpers that operates on system_utsname and then apply
this patch the kernel will still compile, and only later you can
introduce the new stuff.

	Sam
