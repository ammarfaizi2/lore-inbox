Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbTI2ShI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbTI2Sg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:36:58 -0400
Received: from imr2.ericy.com ([198.24.6.3]:51953 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S264267AbTI2Sf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:35:26 -0400
Message-ID: <3F787C81.8060506@ericsson.ca>
Date: Mon, 29 Sep 2003 14:40:01 -0400
From: Jean-Guillaume <jean-guillaume.paradis@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Simple Procfs question: Triggering an "action" when opening a
 directory instead of a file (with seqfile.h)???
References: <3F786E73.6010306@ericsson.ca> <20030929180310.GO7665@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030929180310.GO7665@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Mon, Sep 29, 2003 at 01:40:03PM -0400, Jean-Guillaume wrote:
>  
>
>>Hello everybody :)
>>    
>>
> 
>  
>
>>I need some help on this one, I couldn't find anything on google or in 
>>the archives of the mailing list. Here it goes:
>>
>>I want to trigger an action when "opening" a directory of the procfs. 
>>This is easy for files, but how is it done for directories...???
>>    
>>
>
>With a separate filesystem.  Don't do that on procfs, it's messy enough as
>it is.
>  
>

lol, ok then :)

I have indeed noticed some funny things with the procfs. Like, doing a 
"ls" on my tipc dir  said the directory was empty, but I could do a "vi 
/proc/tipc/file" and see the content of file. Invisible file? :)


