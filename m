Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269594AbUJFWcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269594AbUJFWcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269590AbUJFW3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:29:13 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2192 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269419AbUJFW2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:28:33 -0400
Message-ID: <4164713F.3080506@nortelnetworks.com>
Date: Wed, 06 Oct 2004 16:27:11 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@redhat.com>
CC: hzhong@cisco.com, "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Joris van Rantwijk'" <joris@eljakim.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com> <41645892.9060105@redhat.com>
In-Reply-To: <41645892.9060105@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:

> Again, shouldn't this just mean that recvfrom should not be called 
> without the MSG_ERRQUEUE flag set?

Does a message with a bad udp checksum even get sent up as a queued error message?
