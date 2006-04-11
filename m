Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWDKVEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWDKVEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWDKVEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:04:21 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:20629 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751012AbWDKVEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:04:20 -0400
Message-ID: <443C19C6.80706@vilain.net>
Date: Wed, 12 Apr 2006 09:04:06 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 2/5] uts namespaces: Switch to using uts namespaces
References: <20060407095132.455784000@sergelap> <20060407183600.D025B19B8FF@sergelap.hallyn.com> <443BA062.1040208@sw.ru>
In-Reply-To: <443BA062.1040208@sw.ru>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>Serge,
>
>BTW, have you noticed that NFS is using utsname for internal processes 
>and in general case this makes NFS ns to be coupled with uts ns?
>  
>

Either that, or each NFS vfsmount has a uts_ns pointer.

Sam.
