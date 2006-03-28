Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWC1CTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWC1CTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 21:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWC1CTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 21:19:30 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:43022 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932175AbWC1CT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 21:19:29 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Greg Lee" <glee@swspec.com>
Subject: Re: HZ != 1000 causes problem with serial device shown bygit-bisect
Date: Tue, 28 Mar 2006 03:19:18 +0100
User-Agent: KMail/1.9.1
Cc: "'Lee Revell'" <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       rmk+kernel@arm.linux.org.uk
References: <0ea601c6520b$d586ffb0$a100a8c0@casabyte.com>
In-Reply-To: <0ea601c6520b$d586ffb0$a100a8c0@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603280319.18858.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 03:03, Greg Lee wrote:
> > If it's fixed in 2.6.16, what's the problem?  It's not as if we can go
> > back and fix those old kernels...
> >
> > Lee
>
> I wish!  I can't switch kernels once this one has been qualified without
> major testing headaches.  :-(

Just do what you were planning to; bisect down to the responsible patch. If 
you find it, CC the -stable team if you think it's serious enough, and it 
might end up in the next 2.6.15.x release..

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
