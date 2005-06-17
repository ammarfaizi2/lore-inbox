Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVFQMpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVFQMpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 08:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVFQMpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 08:45:14 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:41680 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261946AbVFQMpI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 08:45:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Id0fJlnxltnF9dj2b6Wh952/trKIIU/59pl6VsU2UW80Gjv3/WQXAHZxtFgoM7o3+f7vHsEk81cYB76sBBHRmh9F6W4h9g5wDyMjA6NJ9lqm3tbAy3iXftzImWe9oPWjpuvI4v4RF0o8N+eMJLyLUDb3hL1a994DrsuKJrbBiwQ=
Message-ID: <4ad99e0505061705453392e0d3@mail.gmail.com>
Date: Fri, 17 Jun 2005 14:45:07 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050617044620.GG8907@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e0505061605452e663a1e@mail.gmail.com>
	 <42B1F5CB.9020308@g-house.de>
	 <4ad99e0505061615143cc34192@mail.gmail.com>
	 <42B21130.4000608@g-house.de>
	 <4ad99e0505061617052f427ed6@mail.gmail.com>
	 <20050617044620.GG8907@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Willy Tarreau <willy@w.ods.org> wrote:
> Maybe some checksumming code has changed, and some of the packets which
> are checksummed by the hardware get wrong on the wire ?

Yes my exact thought, it is fine by me if it is a cisco problem that
needs to be fixed in the firewall but it would be nice knowing what
exactly changed from 2.6.8.1 -> 2.6.9 so it stopped working.


Regards.

Lars Roland
