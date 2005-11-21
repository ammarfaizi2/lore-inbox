Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVKUVa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVKUVa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVKUVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:30:56 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:31963 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750855AbVKUVaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:30:55 -0500
Message-ID: <43823CB3.8090303@austin.rr.com>
Date: Mon, 21 Nov 2005 15:31:31 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eric2.valette@francetelecom.com
CC: linux-kernel@vger.kernel.org
Subject: Re: CIFS improvements/wider testing needed
References: <4381EFF3.8000201@austin.rr.com> <4382032D.4080606@francetelecom.com>
In-Reply-To: <4382032D.4080606@francetelecom.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VALETTE Eric RD-MAPS-REN wrote:

>Steve French wrote:
>  
>
>>Eric,
>>    
>>
>Well I would be surprised the "cat >> titi" command does any of this
>byte range lock. If the "create and later rewrite the same file"
>sequence fails, with a simple cat command (cat > titi ... ^D; cat >>
>titi), how can it works with complicated applications?
>
>  
>
Make sure that you let me know if your cat example works when mounted 
with the relatively new "noperm" mount option on the client.   At least 
then we will know whether we are looking at a problem with access 
control on the server (ntfs acls) or client (unix mode bits and the 
.permission entry point)
