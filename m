Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVE0Csd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVE0Csd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0Csa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:48:30 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:59549
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261407AbVE0CsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:48:18 -0400
Message-ID: <42967C66.1070700@linuxwireless.org>
Date: Thu, 26 May 2005 20:48:22 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Creating patches for source
References: <42967627.5040306@linuxwireless.org> <20050526193437.2fd71090.rdunlap@xenotime.net>
In-Reply-To: <20050526193437.2fd71090.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:

>On Thu, 26 May 2005 20:21:43 -0500 Alejandro Bonilla wrote:
>
>| Hi,
>| 
>|     Quick and fast question here. I'm starting to create patches (diff) 
>| :-) so, I googled for a while and most say that one could use the diff 
>| -up or diff -Naur. They both look to me very similar and honestly -up 
>| works for me. Still, what command will make the cleanest patch and which 
>| one is mostly used?
>
>You looked at 'man diff', right?
>  
>
Yes.

>and linux/Documentation/SubmittingPatches, which says:
>Use "diff -up" or "diff -uprN" to create patches.
>  
>
well, the "or" doesn't tells me the that there is a best way. That's the 
deal.

>So you use the options that are appropriate for your patches.
>
>If you are patching only one file (or a few files in the same
>directory), -up is usually fine.
>  
>
Excelent.

>If you have patches in multiple directories and you want diff
>to search in subdirectories for patches, you need to use -r
>(recursive).
>If you are adding new files, you need to use -N.
>  
>
Adding new files into the whole source? Like it will  make a patch with 
the full content and then create the file when patching the source? 
Thanks for that one, sounds like I will need to use it.

>Is there a specific problem that you are trying to solve?
>  
>
I was just patching a README :-) and the patch looked too big and/or 
bulky, so I noticed it was using a lot of lines from the document, but I 
was only changing a single letter in a word. i.e. I changed/added 20 
letters in total, and the patch is like 200 words.

I think it's just me being a paranoid patch-newbie.

Thanks,

.Alejandro

>---
>~Randy
>
>  
>

