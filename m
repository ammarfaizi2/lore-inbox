Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVAXMzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVAXMzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVAXMzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:55:52 -0500
Received: from imag.imag.fr ([129.88.30.1]:35257 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261340AbVAXMzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:55:47 -0500
Message-ID: <41F4F04B.4020703@imag.fr>
Date: Mon, 24 Jan 2005 13:55:39 +0100
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050109 Fedora/1.7.5-3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Norton <bredroll@darkspace.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: zlib or crypto ?
References: <20050124124326.GA25406@earth.dsh.org.uk>
In-Reply-To: <20050124124326.GA25406@earth.dsh.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 24 Jan 2005 13:55:44 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Norton wrote:
> Hi,
> 
> I'm trying to write a module that uses deflate, I'm wondering which is the best
> point to use the zlib functions from, crypto.h or zlib.h
> 
> i only need to compress data of about 4k in size, 
> 
> any suggesions?
> 
> Regards
> 
> Ian
> 

shouldn't there be only one copy of zlib in the entire kernel ???
