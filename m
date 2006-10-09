Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWJID3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWJID3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWJID3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:29:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61460 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932219AbWJID3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:29:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=skckcLhdW8v3XwJ3k6lv76e9dMBQm9OLQsE/zSvPnsru8FxBHQuMpDMwS3jS5+8Cir4RRZb5rI8FndsgaBEqZEC8ecsGS7Q6Qf2CxqHY/wC6htTMVY+Mu4dAo5MCrm6stkCA1mZvqsv309JlQD9edvpmKHzVVM2njANUzxQmpnw=
Date: Mon, 9 Oct 2006 07:28:51 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] kernel-doc: fix function name in usercopy.c
Message-ID: <20061009032851.GA5344@martell.zuzino.mipt.ru>
References: <20061008194429.c98d7387.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008194429.c98d7387.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 07:44:29PM -0700, Randy Dunlap wrote:
>  /**
> - * strlen_user: - Get the size of a string in user space.
> + * strnlen_user: - Get the size of a string in user space.

It's better to not spend time fixing mismatches, but to teach kernel-doc
extract function name from function itself.

	/**
	 * Get the size of a string in user space.
	 * @foo: bar
	 */
	 size_t strnlen_user()

