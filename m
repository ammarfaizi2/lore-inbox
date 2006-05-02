Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWEBP1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWEBP1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWEBP1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:27:37 -0400
Received: from smtpout.mac.com ([17.250.248.182]:43221 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964885AbWEBP1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:27:37 -0400
In-Reply-To: <44577887.7040506@argo.co.il>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il> <20060502143430.GW27946@ftp.linux.org.uk> <445774F7.5030106@argo.co.il> <20060502151525.GX27946@ftp.linux.org.uk> <44577887.7040506@argo.co.il>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <45D64E85-41E8-4DBC-B8F9-382DA0AA2F36@mac.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Willy Tarreau <willy@w.ods.org>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Compiling C++ modules
Date: Tue, 2 May 2006 11:27:28 -0400
To: Avi Kivity <avi@argo.co.il>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 2, 2006, at 11:19:35, Avi Kivity wrote:
> I wasn't talking about modifying gcc to do the checking, rather  
> using language features so that the checks would happen during a  
> regular compile. That would mean we weren't dependent on somebody  
> running sparse with a configuration that triggers the bug, but  
> those few who compile the code before submitting the patch would  
> get it automatically checked.

There's a reason that we tell all patch submitters to run "make C=1"  
on several configs before submitting patches.  Besides, you seem to  
have a vast misunderstanding of LK development processes; we frown  
heavily on people who don't "compile their code before submitting the  
patch", it's not a rare thing at all.

Cheers,
Kyle Moffett
