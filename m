Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVLTTkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVLTTkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVLTTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:40:20 -0500
Received: from relay10.CS.McGill.CA ([132.206.3.88]:4101 "EHLO
	relay10.cs.mcgill.ca") by vger.kernel.org with ESMTP
	id S1751029AbVLTTkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:40:18 -0500
Message-ID: <43A85E16.2030908@cs.ubishops.ca>
Date: Tue, 20 Dec 2005 14:40:06 -0500
From: Patrick McLean <pmclean@cs.ubishops.ca>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Light-weight dynamically extended stacks
References: <20051219001249.GD11856@waste.org> <20051219183604.GT23349@stusta.de> <20051220002759.GE3356@waste.org> <20051220164316.GG6789@stusta.de> <20051220183025.GG3356@waste.org>
In-Reply-To: <20051220183025.GG3356@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> 
> This is not intended to be an automatic scheme. To use it, you must
> actually insert code into the troublesome codepaths, which will of
> course serve as a red flag for code review.
> 

It might be an idea to put in a #warn to make it an even bigger red 
flag, and to really make people fix this rather than just ignore it 
since it works with the dynamic stacks.
