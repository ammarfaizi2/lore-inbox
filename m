Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVGaGjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVGaGjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 02:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGaGii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 02:38:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:62168 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263202AbVGaGiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 02:38:14 -0400
Message-ID: <42EC71CF.3080908@pobox.com>
Date: Sun, 31 Jul 2005 02:38:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: zaitcev@redhat.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 ub 2/3: Fold one line
References: <20050730225145.4b99ecd0.zaitcev@redhat.com> <20050730.231829.59467939.davem@davemloft.net>
In-Reply-To: <20050730.231829.59467939.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Pete Zaitcev <zaitcev@redhat.com>
> Date: Sat, 30 Jul 2005 22:51:45 -0700
> 
> 
>>-static ssize_t ub_diag_show(struct device *dev, struct device_attribute *attr, char *page)
>>+static ssize_t ub_diag_show(struct device *dev, struct device_attribute *attr,
>>+    char *page)
> 
> 
> FWIW, I am generally against this kind of thing at least
> for non-static functions.
> 
> I used to love this kind of code styling, until I started trying to
> often grep a tree to verify the types of arguments to some function.
> 
> With the above kind of construct, you get the first few types, but not
> all of them, in your grep output.

A better solution would be to stop naming_structures_as_complete_sentences.

IMO there's a happy balance between BSD's squash-everything-into-6-chars 
style and recent kernel code's tendency to bypass the ancient C 32-char 
limit.

But ah well ;-)

	Jeff



