Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVEISG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVEISG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVEISG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:06:58 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:47287 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261473AbVEISGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:06:49 -0400
Message-ID: <427FA6AF.4090803@tiscali.de>
Date: Mon, 09 May 2005 20:06:39 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@linnovative.dk>
CC: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any work in implementing Secure IPC for Linux?
References: <Xine.LNX.4.44.0505091058560.5582-100000@thoron.boston.redhat.com> <200505091940.22260.ks@linnovative.dk>
In-Reply-To: <200505091940.22260.ks@linnovative.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Sørensen wrote:
> On Monday 09 May 2005 17:00, James Morris wrote:
> 
>>On Mon, 9 May 2005, Kristian Sørensen wrote:
>>
>>>Does anyone here know of work being done in order to implement secure IPC
>>>for Linux?
>>
>>What do you mean by secure IPC?
> 
> As I understand it, presently the memory for the message queue is shared based 
> on user and group ownership of the process. By "secure IPC" is meaning a 
> security mechanism that provides a more fine granularity of specifying who 
> are allowed to send (or receive) messages... and maby also a way to resolve 
> the question of "Can I trust the message I received?"
> 
> 
I think the gnumach (sorry for the typo in my last e-mail) concept, fixes 
the sending and receiving permission problem. See the gnumach 
documentation and source code.

Matthias-Christian Ott
