Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVEaHLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVEaHLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVEaHLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:11:39 -0400
Received: from colin.muc.de ([193.149.48.1]:49420 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261209AbVEaHLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:11:35 -0400
Date: 31 May 2005 09:11:30 +0200
Date: Tue, 31 May 2005 09:11:30 +0200
From: Andi Kleen <ak@muc.de>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Message-ID: <20050531071130.GA8458@muc.de>
References: <20050530181626.GA10212@kvack.org> <20050530193823.GD25794@muc.de> <429B7208.6070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B7208.6070804@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >One simple experiment would be to just test if P4 likes the
> >simple rep ; movsq / rep ; stosq loops and enable them.
> >  
> >
> No it doesn't like this sample here at all,I'll get segmentationfault on
> that run.

Sorry, what did you test exactly?

-Andi
