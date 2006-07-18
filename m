Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWGRShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWGRShc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWGRShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:37:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:45299 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932346AbWGRShb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:37:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WjSXrsL6CWG+XUU6ZEHBSEO9l/SiUAPm5VrZiAMM/vAuNisymX9pqv/2QUBS+Mz7ib8tHrOE66vDuHjde0YIVq4ugbEZeZsMWuilm49bd9usL3oDLsWOHVirEtuQrMDVAOAvb+6k2EdXUyyL1rmo3DwWPBWfS9Iqc16zX0LXAhk=
Message-ID: <84144f020607181137u51639699m1fd5c86bc9d078ec@mail.gmail.com>
Date: Tue, 18 Jul 2006 21:37:30 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Hans Reiser" <reiser@namesys.com>
Subject: Re: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
Cc: "Jeff Mahoney" <jeffm@suse.com>, 7eggert@gmx.de,
       "Eric Dumazet" <dada1@cosmosbay.com>,
       "ReiserFS List" <reiserfs-list@namesys.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <44BBDFFC.70601@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6xQ4C-6NB-43@gated-at.bofh.it> <44BAE619.9010307@namesys.com>
	 <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com>
	 <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com>
	 <44BBA4CF.8020901@suse.com> <44BBD4B6.5020801@namesys.com>
	 <44BBD942.3080908@suse.com> <44BBDFFC.70601@namesys.com>
X-Google-Sender-Auth: 5f735c0d2d44a4fe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Hans Reiser <reiser@namesys.com> wrote:
> Replacing / with ! is hideous.  Someone added a nifty elegance to block
> device naming, and you are desecrating it.

You're free to send a patch to fix it all, you know. Until then, lets
make reiserfs consistent with rest of the kernel, ok?
