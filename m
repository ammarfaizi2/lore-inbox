Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264227AbTDJWyo (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264232AbTDJWyo (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:54:44 -0400
Received: from nycsmtp5out-eri0.rdc-nyc.rr.com ([24.29.99.228]:14792 "EHLO
	nycsmtp5out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S264227AbTDJWym (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 18:54:42 -0400
Message-ID: <3E95F8F0.8070704@sixbit.org>
Date: Thu, 10 Apr 2003 19:06:24 -0400
From: John Weber <weber@sixbit.org>
Organization: My Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401 Debian/1.3-4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [FBDEV updates] Newest framebuffer fixes.
References: <Pine.LNX.4.44.0304102231390.23050-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0304102231390.23050-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
>>>Please test. 
>>
>>I get an oops on boot in function fb_set_var (called from 
>>radeon_init_disp).  This might simply be because I don't have the same 
>>version of fbmem.c (I had to apply that hunk of the patch by hand) 
>>although I have source of 2.5.67.
> 
> 
> Yipes. That driver shouldn't be calling fb_set_var from the low level 
> driver. 
>  

By the way, I'm still seeing the boottime oops in radeon_init_disp as a 
result of calling fb_set_var.

(o- j o h n  e  w e b e r
//\  weber@sixbit.org
v_/_  http://weber.sixbit.org/
=====  aim/yahoo/msn: worldwidwebers

