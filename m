Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWF1XYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWF1XYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWF1XYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:24:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:46413 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751777AbWF1XYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:24:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MiE9oBgtQkhpL96N6HE7a4G3h8XAC7rQPQIOqVr5zObihxrdlRvQojv8bvgwaoqM0dKbCqxshV+zKOJ5Vng+KbVzP0nrOXjiiqJ1qMx/lAcAuA2/TFN6n5IWxStN1YI+QQhP/V3j5kY4gGix1oWKzlO+xunrwIcThA6sR8LI+rY=
Message-ID: <ee9e417a0606281624t23f5ccc2qd095b9bf993a0861@mail.gmail.com>
Date: Wed, 28 Jun 2006 16:24:19 -0700
From: "Russ Cox" <rsc@swtch.com>
To: "Eric Sesterhenn / Snakebyte" <snakebyte@gmx.de>
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
In-Reply-To: <20060628231627.GA28463@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151535167.28311.1.camel@alice>
	 <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
	 <20060628231627.GA28463@alice>
X-Google-Sender-Auth: b577d39be705952b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If this is whats agreed upon I will no longer send patches for
> such bugs, and mark them as ignore in the coverity system.
> But I guess it makes also sense to remove unused code, because I
> am not sure if gcc can figure out to remove it. In this case
> the generated object file is 10 bytes smaller.

I wasn't necessarily speaking for the group so much as I was interested
in how coverity was being used and what the rules were.
Thanks for the info.

Russ
