Return-Path: <linux-kernel-owner+w=401wt.eu-S1760223AbWLJE1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760223AbWLJE1D (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 23:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760227AbWLJE1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 23:27:03 -0500
Received: from web57815.mail.re3.yahoo.com ([68.142.236.93]:25164 "HELO
	web57815.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760223AbWLJE1B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 23:27:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FwZRavxP4rvt3lz+UM2hV6u27Y0wdN4m1bGgtLHgktn30rdzb/De334AW16yoaFDy8KuwBY1/dc2VIYGe2yi6QUYjnVYWYMBoyPnQ8Hj4RRQ+wirpwEjvkDYlAhDxSteBvDP++cF3nat5dYw/FFjDs5l6fm2g+vytYh6AJMPn68=  ;
Message-ID: <20061210042700.78990.qmail@web57815.mail.re3.yahoo.com>
Date: Sat, 9 Dec 2006 20:27:00 -0800 (PST)
From: Rakhesh Sasidharan <rakheshster@yahoo.com>
Reply-To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: caglar@pardus.org.tr, Ismail Donmez <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, VCD players are breaking coz they are trying to mount the device and then access files from it. Mounting itself fails, and so the VCD players cant read any files ... that's what I think. 

----- Original Message ----
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Cc: rakheshster@yahoo.com; caglar@pardus.org.tr; Ismail Donmez <ismail@pardus.org.tr>; linux-kernel@vger.kernel.org
Sent: Sunday, December 10, 2006 4:44:42 AM
Subject: Re: VCD not readable under 2.6.18

On Sat, 9 Dec 2006 09:23:32 -0800 (PST)
Rakhesh Sasidharan <rakheshster@yahoo.com> wrote:

> Infact, just inserting a CD is enough. No need for a media player to try and access the files. :)
> 
> The backend must be polling and trying to mount the disc upon insertion. Kernel 2.6.16 and before did that fine, but kernel 2.6.17 and above don't and give error messages. Which explains why downgrading the kernel solves the problem. (If it were a HAL or KDE/ GNOME problem then shouldn't downgrading the kernel *not* help?) Just thinking aloud ... 

The old kernel erroneously failed to report errors in some cases so the
answer to that bit is a definite  - no -. That side is a desktop problem.
The fact people are saying that in addition vcd players are breaking is a
bit more mysterious.





 
____________________________________________________________________________________
Need a quick answer? Get one in minutes from people who know.
Ask your question on www.Answers.yahoo.com
