Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbULHVRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbULHVRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbULHVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:17:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:31695 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261360AbULHVRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:17:08 -0500
Message-ID: <41B76443.2040205@osdl.org>
Date: Wed, 08 Dec 2004 12:29:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: Ulrich Drepper <drepper@redhat.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: host name length
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org> <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr> <41B48C9E.6030607@osdl.org> <41B49773.1010006@domdv.de> <41B4B210.1040105@redhat.com> <41B4B2CD.80209@domdv.de>
In-Reply-To: <41B4B2CD.80209@domdv.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> Ulrich Drepper wrote:
> 
>> Yes, each label can only have 63 bytes, but the entire fqdn can be
>> longer, much longer.  And the hostname stored with sethostname() should
>> be the fqdn of the machine, not just one lalbel (in DNS speak).
> 
> 
> 255 characters to be exact. The question was, however, for the hostname 
> which I usually don't interpret as a fqdn.

So sethostname(2) sets fqdn, right?

Ulrich, do you want help on this or is it already done?

-- 
~Randy
