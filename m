Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274311AbRITFGA>; Thu, 20 Sep 2001 01:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274312AbRITFFu>; Thu, 20 Sep 2001 01:05:50 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36525 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274311AbRITFFi>; Thu, 20 Sep 2001 01:05:38 -0400
Date: Thu, 20 Sep 2001 01:05:02 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Christopher K. St. John" <cks@distributopia.com>
Cc: linux-kernel@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010920010502.A7960@redhat.com>
In-Reply-To: <XFMail.20010919192804.davidel@xmailserver.org> <3BA97155.4D2D53AC@distributopia.com> <3BA9740D.DD16AE9E@distributopia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA9740D.DD16AE9E@distributopia.com>; from cks@distributopia.com on Wed, Sep 19, 2001 at 11:43:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 11:43:57PM -0500, Christopher K. St. John wrote:
>  Sorry, bad editing, that should be:
> 
>  Assume a large but bursty current of low bandwidth
> high latency connections instead of a continuous steady
> flood of high bandwidth low latency connections.

Isn't asynchronous io a better model for that case?

		-ben
