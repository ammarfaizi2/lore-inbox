Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUGQAUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUGQAUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 20:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUGQAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 20:20:10 -0400
Received: from [213.239.201.226] ([213.239.201.226]:25749 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S266654AbUGQAUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 20:20:04 -0400
Message-ID: <40F87329.9080109@shadowconnect.com>
Date: Sat, 17 Jul 2004 02:30:33 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <Pine.LNX.4.58.0406011228130.1794@montezuma.fsmlabs.com> <40BDC553.4060809@shadowconnect.com> <Pine.LNX.4.58.0407161328030.26950@montezuma.fsmlabs.com> <40F810B2.40600@pobox.com>
In-Reply-To: <40F810B2.40600@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
> I would need to see the hardware specs, but I really think some 
> alternate mapping solution needs to be found.

Okay, i've limit the mapped memory, and it seems to work :-)

> "map the entire area" may be easy, but in this case isn't the best 
> solution.

Yes, i agree with you. I'll try to find out, if there is a way to get 
the real size, and only map this area.



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
