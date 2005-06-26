Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVFZToC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVFZToC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVFZTmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:42:15 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:21157 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261610AbVFZTll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:41:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UFBQYDbC0Gls2HihQUgaUxj7CPclnb/XStbwGcfSqCB2aE64+0MjtLbkA+KvdWxHzytmub5VnyEwARHIdTXEbPsEq21L3keBvB5/IQW0SfHkLiAo2F4heVD49fedoHnlv71vjdPG+azGpfzUKErNY4Fu/kDUaYAVjtkEQPUBD5o=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Frank Peters <frank.peters@comcast.net>
Subject: Re: Asus MB and 2.6.12 Problems
Date: Sun, 26 Jun 2005 23:47:46 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050624113404.198d254c.frank.peters@comcast.net>
In-Reply-To: <20050624113404.198d254c.frank.peters@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506262347.46821.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 19:34, Frank Peters wrote:
> Also, after a successful boot with 2.6.12, I will attempt to
> connect with my cable Internet service using the following
> commands:
> 
> modprobe 3c59x  (load the ethernet modules)
> dhcpcd -t 240   (get the IP address from my ISP)
> 
> Formerly, with kernels 2.6.11 and earlier, the connection could
> be established very quickly (about 10-15 seconds).  But with
> kernel 2.6.12, it now requires about 3-4 minutes to establish
> the link.

I've filed a bug at kernel bugzilla for this part of the problem, so your
report won't be lost. See http://bugme.osdl.org/show_bug.cgi?id=4803

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.

P. S.: Compilation for keyboard problem will be filed RSN.
