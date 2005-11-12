Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVKLAzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVKLAzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVKLAzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:55:44 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:32482 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750833AbVKLAzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:55:43 -0500
Date: Fri, 11 Nov 2005 16:56:09 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Alex Song <asong@ati.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Question] PCI device memory management
Message-ID: <20051112005609.GA25730@plexity.net>
Reply-To: dsaxena@plexity.net
References: <18860D00A1C724419B900535DB985FB4016140E0@torcaexmb2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18860D00A1C724419B900535DB985FB4016140E0@torcaexmb2.atitech.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 11 2005, at 16:53, Alex Song was caught saying:
> Hi,
> 
> Our PCI device has a lot of memory and we have to provide memory
> management function for it. 
> 
> Does kernel already have this mechanism in place?
> 
> Or we have to manage it on our own?

I'm guessing what you mean is that there is more memory on the
device then can be mapped in via the outbound window?  You will
have to carve it up into chunks and map/unmap regions as needed.
Can you provide a bit more detail on what exactly you need to do?

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
