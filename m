Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbULABfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbULABfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULABes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:34:48 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:63797 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261171AbULABdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:33:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qxkOGNdZx+/0pszMNV27xUtK7YyUuAs3dabBS2ktQGA4rSNjT0eQSDAHQQyJKEt+is9+YMgxEk3cQ4b2Xo6+HMSG2YP1hya754+OnNzyRbki4IjDwb9IldcFI73DXinAW8Dllq1J5JL7LXTZ/LDukLhb2FeN8iKqS1wVZzCissY=
Message-ID: <c0a09e5c04113017333c85c7e2@mail.gmail.com>
Date: Tue, 30 Nov 2004 17:33:17 -0800
From: Andrew Grover <andy.grover@gmail.com>
Reply-To: Andrew Grover <andy.grover@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: "extern inline" purge? was: Re: [PATCH] fix "extern inline"
In-Reply-To: <m2y8hapakk.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <m2y8hapakk.wl%ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004 13:55:23 +0900, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> -extern __inline__ int generic_fls(int x)
> +static __inline__ int generic_fls(int x)

Along the lines of this patch, can I ask... if a patch were created to
replace all instances of "extern inline" with "static inline" would
that be a good thing or a waste of time? I found a 3 year old thread
(Jul 27 2001, "Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1") where it sounded
like a good thing to do, but obviously there are some still around.

Regards -- Andy
