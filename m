Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbUL3WN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbUL3WN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 17:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUL3WN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 17:13:59 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:27049 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261730AbUL3WN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 17:13:57 -0500
Date: Thu, 30 Dec 2004 23:13:56 +0100
From: bert hubert <ahu@ds9a.nl>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finding whether a process blocked while executing a syscall
Message-ID: <20041230221356.GB15202@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	selvakumar nagendran <kernelselva@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20041230045236.19022.qmail@web60606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230045236.19022.qmail@web60606.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 08:52:36PM -0800, selvakumar nagendran wrote:

>     A process can be blocked while executing a syscall
> in the light of some resources needed. Now, I want to
> find out whether a process has been blocked while
> executing a particular syscall or it has finished it
> successfully? If it was blocked I want to perform some
> operation on it. Can anyone help me regarding this?

This question is fraught with difficulty. For one thing, many many system
calls will block for a short time, which you would probably not describe as
'blocked', even though this was true for a few milliseconds.

You did not entirely specify why you want to do this, there may be better
solutions to your problem.

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
