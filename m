Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbULaGIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbULaGIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 01:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbULaGIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 01:08:36 -0500
Received: from web60603.mail.yahoo.com ([216.109.118.223]:24244 "HELO
	web60603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261672AbULaGIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 01:08:32 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=4eAIpzSaSw83b8bpi1QcOq+mm1348fdCGy+lVwMlNYKZH/zObnL7K1NAzLpxTCiizntznn70CZO19iIKgMjjTZ5EnfRv2SMkHxBQpUNw4qfzGPR6aDtMKui+uXL2l87JRhYS/MKUfyPcck3IUMkOzRrcBbMlDuOLSi2mCP5Ln8c=  ;
Message-ID: <20041231060832.97559.qmail@web60603.mail.yahoo.com>
Date: Thu, 30 Dec 2004 22:08:32 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Resource unavailabilty on a syscall
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041230221356.GB15202@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for ur help,
   For a syscall to complete successfully, a process
should acquire the particular resource like
filelock,semaphore key etc. Now, I want to determine
whether a process blocked only due to the
unavailability of a semaphore key or a file lock etc.
I accept a process may block on a syscall for many
reasons. But I want to determine it for resource
starvation alone. How can I do that?
Do u have any suggestions regarding this?

Regards,
selva

--- bert hubert <ahu@ds9a.nl> wrote:

> On Wed, Dec 29, 2004 at 08:52:36PM -0800, selvakumar
> nagendran wrote:
> 
> >     A process can be blocked while executing a
> syscall
> > in the light of some resources needed. Now, I want
> to
> > find out whether a process has been blocked while
> > executing a particular syscall or it has finished
> it
> > successfully? If it was blocked I want to perform
> some
> > operation on it. Can anyone help me regarding
> this?
> 
> This question is fraught with difficulty. For one
> thing, many many system
> calls will block for a short time, which you would
> probably not describe as
> 'blocked', even though this was true for a few
> milliseconds.
> 
> You did not entirely specify why you want to do
> this, there may be better
> solutions to your problem.
> 
> bert
> 
> -- 
> http://www.PowerDNS.com      Open source, database
> driven DNS Software 
> http://lartc.org           Linux Advanced Routing &
> Traffic Control HOWTO
> 



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

