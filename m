Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269602AbUJFXk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbUJFXk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269620AbUJFXhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:37:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21633 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269440AbUJFXeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:34:11 -0400
Message-ID: <416480A7.5070408@redhat.com>
Date: Wed, 06 Oct 2004 19:32:55 -0400
From: Neil Horman <nhorman@redhat.com>
Reply-To: nhorman@redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: hzhong@cisco.com, "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Joris van Rantwijk'" <joris@eljakim.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com> <41645892.9060105@redhat.com> <4164713F.3080506@nortelnetworks.com>
In-Reply-To: <4164713F.3080506@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Neil Horman wrote:
>
>> Again, shouldn't this just mean that recvfrom should not be called 
>> without the MSG_ERRQUEUE flag set?
>
>
> Does a message with a bad udp checksum even get sent up as a queued 
> error message?

I thought thats exactly what MSG_ERRQUEUE was for, or am I mistaken?
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

