Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271713AbTHDMiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271714AbTHDMiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:38:18 -0400
Received: from [209.88.178.130] ([209.88.178.130]:11283 "EHLO
	hirame.qlusters.com") by vger.kernel.org with ESMTP id S271713AbTHDMiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:38:17 -0400
Message-ID: <3F2E51EF.6040208@qlusters.com>
Date: Mon, 04 Aug 2003 15:30:39 +0300
From: eliezer <eliezer@qlusters.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: linux-kernel@vger.kernel.org, devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from
 being modified easily
References: <20030803180950.GA11575@outpost.ds9a.nl> <20030803210821.GA17710@codepoet.org>
In-Reply-To: <20030803210821.GA17710@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

>bert hubert wrote:
>  
>
>>Greetings,
>>
>>
>>It blocks attempts by rootkits, such as devik's SucKIT, to hide themselves.
>>    
>>
>
>Until the rootkit, already running as root, loads stuff as a
>kernel module...  Perhaps you should make this enforce that
>people have CONFIG_MODULES=n,
>
>  
>
(on a diff thread you talked about doing this dynamically)
Maybe you should also disable module loading.
has anyone already done such a thing as disabling module loading after a 
point in system startup?

Eliezer

