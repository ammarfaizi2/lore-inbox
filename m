Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVHWHyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVHWHyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVHWHyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:54:45 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:29814 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750882AbVHWHyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:54:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=faxSICnQVMOSTcdhKkr5rH7HBkbklYJDVFwp1XZ9+iO+7uCdfca+3BQ+/LIHJjJjTL7rtYHPXCWyiLdO00VpZDIFc/JobKJhUQGPBryEKHO+E/+Z4T0sGfb8T/nEqCBfuOK6kH/MMK//O7Ag7+USZxoRxT/qNBf/PHYdxPl6wE8=
Message-ID: <430AD4FB.7050908@gmail.com>
Date: Tue, 23 Aug 2005 10:49:15 +0300
From: gxkahn <gxkahn@gmail.com>
Reply-To: gxkahn@gmail.com
Organization: Softier
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: en-us, en, he, ru
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: [proposal] remove struct file *file from aops
References: <2cd57c90050823001855403664@mail.gmail.com>
In-Reply-To: <2cd57c90050823001855403664@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

>Hello,
>
>The argument struct file *file in aops { .readpage, .readpages,
>prepare_write, .commit_wirte } is not used.  I'd like to file a series
>of patches to clean it up. Are there any other concerns?
>
>thanks
>  
>
It used with HTTPFS or FTPFS. Should be checked with FUSE people.
