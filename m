Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUK0UnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUK0UnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 15:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUK0UnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 15:43:24 -0500
Received: from relay01.pair.com ([209.68.5.15]:12049 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261321AbUK0UnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 15:43:22 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <41A8D8CA.9090309@kegel.com>
Date: Sat, 27 Nov 2004 11:43:06 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Stohr wrote:
>> Matthew Wilcox wrote:
>> > Indeed.  We could also make this transparent to userspace by using a script
>> > to copy the user-* headers to /usr/include.  Something like this:
> 
> some administrator would like to only create symlinks for saving disk space.
> 
> others would like a true "install" with copying files so that they can delete
> the kernel sources anytime they do want.
> 
> for me i would install all those kernel realted files into 
> the well known /lib/modules/<kernel-version>. 

IMHO the script should let you install the headers
wherever you like.  In particular, in crosstool,
I would like to install the headers somewhere like
/opt/crosstool/$TARGET/include rather than /usr/include.
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
