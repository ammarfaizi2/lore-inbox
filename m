Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTKABc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 20:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTKABc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 20:32:58 -0500
Received: from mail.broadpark.no ([217.13.4.2]:16845 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262282AbTKABc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 20:32:57 -0500
To: sankar <san_madhav@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: pthread mutex question
References: <Sea2-DAV35RuMrzpeSK0000db71@hotmail.com>
Message-ID: <oprxxqjgqeq1sf88@mail.broadpark.no>
From: Arve Knudsen <aknuds-1@broadpark.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Sat, 01 Nov 2003 02:31:54 +0100
In-Reply-To: <Sea2-DAV35RuMrzpeSK0000db71@hotmail.com>
User-Agent: Opera7.21/Linux M2 build 480
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its C++, but you could have a look at the boost::thread::timed_mutex 
(www.boost.org) implementation, which makes use of pthread_cond_timedwait.

Regards

Arve Knudsen

On Fri, 31 Oct 2003 16:43:14 -0800, sankar <san_madhav@hotmail.com> wrote:

> Hi,
> I am looking for an idea as to how to implement timed mutex using pthread
> libraries on linux.
> Basically I want to associate a timeout value with the wait function i,e
> pthread_mutex_lock() which returns once the timeout expires instaed of
> waiting for ever.
> Pls help
>
> thx..
>
> Sankarshana M
