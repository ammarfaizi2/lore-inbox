Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268106AbUHFImy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268106AbUHFImy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268103AbUHFImJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:42:09 -0400
Received: from webapps.arcom.com ([194.200.159.168]:57607 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268110AbUHFIk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:40:27 -0400
Message-ID: <411343F9.1080301@arcom.com>
Date: Fri, 06 Aug 2004 09:40:25 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: cross-depmod?
References: <1091742716.28466.27.camel@localhost>
In-Reply-To: <1091742716.28466.27.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2004 08:42:42.0234 (UTC) FILETIME=[5658A1A0:01C47B91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:
> 
> My problem is that I cross-build my kernels, and 'make rpm' is very
> unhappy when it can't use depmod. I know that I can do 'make
> DEPMOD=/bin/true rpm', but can't we figure that out automatically?

I'd suggest not running depmod when building an RPM but instead run it 
as part of the RPMs post-installation script.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
