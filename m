Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVHWTa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVHWTa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVHWTa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:30:58 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:7288 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932330AbVHWTa5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:30:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cwRz+l7DBgeTE4KH4D63CeTJET+hph/skitZFRX75U0HaMQLUiZ+JGDBnmPDOH4IjGZufuW0ejmYGi0eaw32xIzN0wO62H5XU/C7V59VbdH0if3GdE2Fu4zkflsqvzjJDp7UgOocYC3TPF6EwvSSynRildU8cEhMFGFjcDtr1x8=
Message-ID: <b3f2685905082312301868f00e@mail.gmail.com>
Date: Tue, 23 Aug 2005 21:30:56 +0200
From: Jari Sundell <sundell.software@gmail.com>
To: Davy Durham <pubaddr2@davyandbeth.com>
Subject: Re: select() efficiency / epoll
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <430AF11A.5000303@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E162B6.2000602@davyandbeth.com>
	 <20050722212454.GB18988@outpost.ds9a.nl>
	 <430AF11A.5000303@davyandbeth.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Davy Durham <pubaddr2@davyandbeth.com> wrote:
> 
> However, I'm getting segfaults because some pointers in places are
> getting set to low integer values (which didn't used to have those values).

Is it possible that you are overwritting the pointers with file
descriptors, as those would have low integer values?

-- 
Rakshasa

Nyaa?
