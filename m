Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285070AbRLLDgK>; Tue, 11 Dec 2001 22:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285071AbRLLDgA>; Tue, 11 Dec 2001 22:36:00 -0500
Received: from ohiper0-240.apex.net ([209.250.50.240]:39694 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S285070AbRLLDfn>; Tue, 11 Dec 2001 22:35:43 -0500
Date: Tue, 11 Dec 2001 21:35:15 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v2.5.1-pre9-00_kvec.diff
Message-ID: <20011211213515.D29224@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011211162639.F6878@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211162639.F6878@redhat.com>; from bcrl@redhat.com on Tue, Dec 11, 2001 at 04:26:39PM -0500
X-Uptime: 7:05pm  up 15 days,  1:56,  1 user,  load average: 1.23, 1.21, 1.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	nr_pages = (ptr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	nr_pages -= ptr >> PAGE_SHIFT;

Isn't this the same as
	nr_pages = (len + PAGE_SIZE -1) >> PAGE_SHIFT;
?  Or am I missing something?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
