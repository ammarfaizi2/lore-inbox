Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWAMQWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWAMQWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWAMQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:22:00 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:55119 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422732AbWAMQV6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:21:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mEDaPyX04ntIYJBVXhh7ro8dm0y7QjONjvlC0zCkyKzGgBhIToV227fn+VTBPq8VMM8meJfw0hPLE6Z39kttisrYrzb0FxilQL/QpgwXtuZYQ8FF8/R7RzLOJBcosXMUJrNFSXg89nmfBo5FisPX6t89wD7T2RCMbtDPAH0lYrI=
Message-ID: <728201270601130814k37c31f7bxd04a1fe44213b430@mail.gmail.com>
Date: Fri, 13 Jan 2006 10:14:37 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: jeff shia <tshxiayu@gmail.com>
Subject: Re: something about disk fragmentation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7cd5d4b40601130158l274a3b19t13f2a58a28cc3819@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7cd5d4b40601110501w40bc28f0peb13cdbb082e2b4a@mail.gmail.com>
	 <728201270601110633i2eb8c71dq8a0c23d9e7ad724f@mail.gmail.com>
	 <7cd5d4b40601130158l274a3b19t13f2a58a28cc3819@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, jeff shia <tshxiayu@gmail.com> wrote:
> Where Can I get the io schedulers?
> Thank you!

See the documentation under the kernel source tree. The code is
already there. You need only to select by passing correct kernel
parameters.
elevator=       [IOSCHED]
                        Format: {"as" | "cfq" | "deadline" | "noop"}
                        See Documentation/block/as-iosched.txt and
                        Documentation/block/deadline-iosched.txt for details.

Regards
Ram Gupta
