Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWGJL1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWGJL1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGJL1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:27:25 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:62667 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751338AbWGJL1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:27:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=ikPw+cnZuXuhkh/cJYHAlGUln+xNwqVkq+a7BxeE+y0BUfjE22R92h5YyYqazrE+z5Lp24RBY+feZviowDa2aHGAmM5MXTqVOBprxshF4azaSLrEaONte2r6jHFFf8lpUiB7qaJZgvMcCapZUlASI0J3fUDBABOzGvToXSlZl1I=
Message-ID: <44B2398B.7040300@pol.net>
Date: Mon, 10 Jul 2006 19:27:07 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org>	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net> <m3mzbh68g9.fsf@defiant.localdomain>
In-Reply-To: <m3mzbh68g9.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> "Antonino A. Daplas" <adaplas@pol.net> writes:
> 
>> There are better reasons (ie, smaller patch), but worse readability is not
>> one of them.
>>
>> I could more easily grasp the code flow of cirrusfb_register() if you
>> just inserted "cirrusfb_create_i2c_buses()" instead of:
> 
> Feel free to add another patch, while I don't see a need I have nothing
> against :-)

No, you fix the patch.  And while your at it, check your Kconfig
dependencies, ie check for impossible combinations such as CONFIG_I2C=m,
CONFIG_FB_CIRRUS=y.

Tony
