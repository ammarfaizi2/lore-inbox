Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVDYQAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVDYQAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVDYP73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:59:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46310 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262668AbVDYP4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:56:36 -0400
Date: Mon, 25 Apr 2005 21:26:49 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Juergen Quade <quade@hsnr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system-freeze: kprobe and do_gettimeofday
Message-ID: <20050425155649.GA30272@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050423101251.GA327@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423101251.GA327@hsnr.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 12:12:51PM +0200, Juergen Quade wrote:
> Playing around with kprobe I noticed, that "kprobing"
> the function "do_gettimeofday" completly freezes the
> system (2.6.12-rc3). Other functions like "do_fork" or

Kprobe on "do_gettimeofday" seems to work fine on 4-way SMP i386 box.
What is configuration of your machine?

Thanks
Prasanna

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
