Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287965AbSAHHRP>; Tue, 8 Jan 2002 02:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287960AbSAHHRF>; Tue, 8 Jan 2002 02:17:05 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:65417 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S287957AbSAHHQ4>;
	Tue, 8 Jan 2002 02:16:56 -0500
Date: Tue, 8 Jan 2002 02:17:14 -0500
Subject: Re: Whizzy New Feature: Paged segmented memory
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: <linux-kernel@vger.kernel.org>
To: Jacques Gelinas <jack@solucorp.qc.ca>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <20020107224525.8a899969dbcd@remtk.solucorp.qc.ca>
Message-Id: <BD98BECA-0407-11D6-804A-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, January 7, 2002, at 10:45 , Jacques Gelinas wrote:

> Another solution would be to have two stacks. One for variable 
> (auto data)
> and one for program execution (call). Beside cache effect, this 
> would provide
> mostly the same performance as we get now. Just wondering if 
> someone had
> toyed with this idea.

A nice thing about two stacks is that it can be a completely 
userspace thing. No need to involve the kernel at all; just gcc 
and friends.

