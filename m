Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWFBOHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWFBOHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFBOHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:07:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:30635 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932118AbWFBOHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:07:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MTUNlb9Wq/USEhaWMKIROaLmhPVIFW2GXMvj5LV4Ef6968raBbt3mMXYq6gP1ujnFBzQekaMnEpcKkbeHCW/Gj8nmnM6mPwqsU3tHuBdwESQ67tMUX+ly1wjO9KEaZTBDUi7AXu+Ado2xtVxpDh28Vw9+GEJkyhaSkrdJRjU+78=
Message-ID: <79a6fb1e0606020707m626d56efs366b6159263d660b@mail.gmail.com>
Date: Fri, 2 Jun 2006 15:07:38 +0100
From: fonseka@gmail.com
To: "Roger Luethi" <rl@hellgate.ch>
Subject: Re: BUG: scheduling while atomic
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060602123759.GA26323@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <79a6fb1e0606020239i49c38effxc688c12f94d5da41@mail.gmail.com>
	 <20060602123759.GA26323@k3.hellgate.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, Roger Luethi <rl@hellgate.ch> wrote:
> On Fri, 02 Jun 2006 10:39:01 +0100, fonseka@gmail.com wrote:
> > recently I'm trying putting snmpd working on a old machine and ran into
> > problems... everytime i try to spawn the snmpd process I got a kernel
> > backtrace as follows, and the process never cames up:
>
> The patch that caused the backtrace has been reverted in 2.6.17-rc5.

great.. installed 2.6.17-rc5, rebooted, started snpd and it true, no
backtrace... but also... no process is spawned... no snmpd is created,
no error, nothing on logs, nothing :( :( i'm cursed....


> Roger
>


-- 
Will work for bandwidth
