Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266422AbTGJWWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbTGJWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:22:47 -0400
Received: from c3po.aoltw.net ([64.236.137.25]:10424 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id S266422AbTGJWWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:22:45 -0400
Message-ID: <3F0DEAA0.4050909@netscape.com>
Date: Thu, 10 Jul 2003 15:37:20 -0700
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel McNeil <daniel@osdl.org>
CC: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH libaio] add timeout to io_queue_run and remove	io_queue_wait
References: <1057712224.11509.35.camel@dell_ss5.pdx.osdl.net> 	<3F0C97C0.2060408@netscape.com> <1057794581.10851.66.camel@dell_ss5.pdx.osdl.net>
In-Reply-To: <1057794581.10851.66.camel@dell_ss5.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking through the linux-aio archives, it seems I  was confusing 
io_queue_run() with io_queue_init() and io_queue_release(), which Ben 
LaHaise reports as being used by Oracle.  In any case, I have no 
objection to removing io_queue_run() or io_queue_wait().  But then I 
don't maintain the library.



