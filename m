Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWB0SuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWB0SuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWB0SuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:50:20 -0500
Received: from [200.55.139.213] ([200.55.139.213]:30161 "EHLO proxy2.uh.cu")
	by vger.kernel.org with ESMTP id S1751578AbWB0SuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:50:19 -0500
Message-ID: <44035886.4070306@uh.cu>
Date: Mon, 27 Feb 2006 14:52:38 -0500
From: Yoanis Gil Delgado <fred@uh.cu>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: creating live virtual files by concatenation
References: <1271316508.20060225153749@dns.toxicfilms.tv> <Pine.LNX.4.61.0602251629560.13355@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602251629560.13355@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>Now let us say I am creating sort of a virtual text file (code.js)
>>that is a live-concatenation of these files:
>># concatenate tooltip.js banner.js foo.js code.js
>>
>>Note I am not talking about the cat(1) utility. I am thinking of
>>code.js be always a live concatenated version of these three, so when
>>I modify one file, the live-version is also modified.
>>
>>What puprose I might have? Network-related. Say, I have an HTML file
>>that includes these three files in its code.
>>
>>    
>>
>Try FUSE.
>  
>
Yes that's the best solution. Email me if you have a question about how 
to accomplish this. Here at
our school we have created a fuse filesystem that "glues" files in a 
single one.

>  
>
>>If I had a live-concatenated file, I could reference it in the HTML file
>>so that the browser does not have to download three files but just one.
>>
>>This would surely reduce network overhead of downloading the same amount
>>of data but within just one connection, reduce resource usage on the client
>>and possibly (depending on implementation) reduce the cost of accessing
>>three individual files on the server.
>>
>>    
>>
>Have you ever heard of persistent connections with HTTP/1.1?
>
>
>Jan Engelhardt
>  
>

