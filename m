Return-Path: <linux-kernel-owner+w=401wt.eu-S932596AbWLSHlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWLSHlQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWLSHlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:41:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:8852 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbWLSHlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:41:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FzAfvsdvIFy9DQEYejQGhaMUpQ9NeUyXG91mJvhqT/WHuJokArHmoao31DApTGLbXMZ7LASGFz3IwTne8e0ksfoRSfSxmjk70zHR+yBN6PcYvkkY2Yx7/MnBrl2P+j8OVNTTfFgeZhCRDh974TtueZES5WU3AChGX+rgfrU9MDU=
Message-ID: <6d6a94c50612182341m106eb56ctcd1bcc849aec6c23@mail.gmail.com>
Date: Tue, 19 Dec 2006 15:41:12 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] Fix area->nr_free-- went (-1) issue in buddy system
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <458787FF.6080404@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50612181901m1bfd9d1bsc2d9496ab24eb3f8@mail.gmail.com>
	 <458760B0.7090803@yahoo.com.au>
	 <6d6a94c50612182216r15cd99a3p59bbe3d49cb482f0@mail.gmail.com>
	 <458787FF.6080404@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Hi Aubery!
>
> That's right. I guess you can either align your zone sizes (must be
> aligned to MAX_ORDER size), or add the zone check in page_is_buddy.
>
Adding the zone check in page_is_buddy fix the problem.
Thanks again, :)

-Aubrey
