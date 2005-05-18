Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVERRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVERRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVERRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:33:09 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:23384 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262189AbVERRdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:33:05 -0400
Message-ID: <428B7C4E.7030901@tls.msk.ru>
Date: Wed, 18 May 2005 21:33:02 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
References: <428B1A60.6030505@inescporto.pt> <20050518134031.53a3243a@phoebee>
In-Reply-To: <20050518134031.53a3243a@phoebee>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel wrote:
> On Wed, 18 May 2005 11:35:12 +0100
> Filipe Abrantes <fla@inescporto.pt> bubbled:
> 
>>Hi all,
>>
>>I need to detect when an interface (wired ethernet) has link up/down.
>>Is  there a system signal which is sent when this happens? What is the
>>best  way to this programatically?
> 
> mii-tool?

BTW, it might be a good idea to trigger some hotplug event on
interface up/down... or just send a netlink message. instead of
polling the interface.  The same applies to removable media too
(CD or ZIP drive).

/mjt
