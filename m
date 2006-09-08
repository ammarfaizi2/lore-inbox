Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWIHS7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWIHS7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWIHS7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:59:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63854 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750896AbWIHS7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:59:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jMWZejZjqDQrsa8tRpIzvZ4boyYmRRnKWhMP4Gv+C7/uR1IUmWNbivpzWl1UmyQdIB5DwQ8wipnqK/7lxwRQ6vgaCi6mRpYbUO4o3AXLL5/2tLdWMSgFmYeyz7ekcYEzSbwBimNEzAu7oEKw7FVUIHNMvNMXFzpL+BNaUzKoalg=
Date: Fri, 8 Sep 2006 22:59:14 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060908185914.GA5191@martell.zuzino.mipt.ru>
References: <20060908031422.GA4549@lists.us.dell.com> <20060908112035.f7a83983.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908112035.f7a83983.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:20:35AM -0700, Andrew Morton wrote:
> > +extern void pci_sort_breadthfirst(void);
>
> In which case this needs the __init tag too (new rule, due to frv (at least)).

Some time ago I've asked David Howells about it:

	> Does this apply to function prototypes?

	No, because functions can't be crammed into such a small space.

