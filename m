Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269712AbUJGFqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbUJGFqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269710AbUJGFqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:46:23 -0400
Received: from relay.pair.com ([209.68.1.20]:2827 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269711AbUJGFps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:45:48 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4164CB02.2030607@kegel.com>
Date: Wed, 06 Oct 2004 21:50:10 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, joris@eljakim.nl
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joris wrote:
> On Wed, 6 Oct 2004, Andries Brouwer wrote:
>> Does this really happen?
> 
> Yes. Finally got my raw-udp-with-wrong-checksum sending program to work
> over localhost and it hangs recvfrom pretty good.
> 
>> All kernel versions?
> 
> Quick guess: probably since late 2.4. Source of 2.4.27 udp.c is similar to
> 2.6.9, but 2.4.17 returns EAGAIN even for blocking sockets, apparently
> this was "fixed" later on.

It would be nice to know how other operating systems behave
when receiving UDP packets with bad checksums.  Can someone
try BSD and Solaris?

- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
