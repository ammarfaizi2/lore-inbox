Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVDZFJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDZFJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDZFJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:09:52 -0400
Received: from smtp.istop.com ([66.11.167.126]:12469 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261319AbVDZFJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:09:51 -0400
From: Daniel Phillips <phillips@istop.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH 1a/7] dlm: core locking
Date: Tue, 26 Apr 2005 01:10:00 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050425165705.GA11938@redhat.com> <Pine.LNX.4.62.0504252242510.2941@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504252242510.2941@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200504260110.01115.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 17:17, Jesper Juhl wrote:
> > +     int error = -ENOMEM, last_len, count = 0;
>
> Wouldn't
>         int error = -ENOMEM;
>         int last_len;
>         int count = 0;
> be a bit more readable?

The rest of your nits are fine, upstanding nits, but this one seems a little 
extreme :-)

Regards,

Daniel
