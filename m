Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264166AbUEXXnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbUEXXnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUEXXnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:43:33 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:49369 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264166AbUEXXna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:43:30 -0400
Message-ID: <40B28896.1000606@myrealbox.com>
Date: Mon, 24 May 2004 16:43:18 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Modifying kernel so that non-root users have some root capabilities
References: <fa.nbdv424.kmij3i@ifi.uio.no>
In-Reply-To: <fa.nbdv424.kmij3i@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Laughlin, Joseph V wrote:
> (not sure if this is a duplicate or not.. Apologies in advance.)
> 
> I've been tasked with modifying a 2.4 kernel so that a non-root user can
> do the following:
> 
> Dynamically change the priorities of processes (up and down)
> Lock processes in memory
> Can change process cpu affinity

Capabilities should do this, but they don't.  See the huge thread
on capabilities these past couple weeks.

You're probably best off with a setuid-root executable.

--Andy
