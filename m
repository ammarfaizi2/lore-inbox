Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWDGUrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWDGUrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWDGUrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:47:48 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:31426 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964949AbWDGUrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:47:47 -0400
Date: Fri, 7 Apr 2006 16:47:44 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       devel@openvz.org
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
In-Reply-To: <20060407183600.C8A8F19B8FD@sergelap.hallyn.com>
Message-ID: <Pine.LNX.4.64.0604071645230.13532@d.namei>
References: <20060407095132.455784000@sergelap> <20060407183600.C8A8F19B8FD@sergelap.hallyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2006, Serge E. Hallyn wrote:


> +EXPORT_SYMBOL(unshare_uts_ns);
> +EXPORT_SYMBOL(free_uts_ns);

Why not EXPORT_SYMBOL_GPL?

What do you expect the user api to look like, a syscall?

Probably need to think about LSM hooks for creating and updating the 
namespaces.


- James
-- 
James Morris
<jmorris@namei.org>
