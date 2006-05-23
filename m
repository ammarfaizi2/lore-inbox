Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWEWUdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWEWUdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWEWUdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:33:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:21772 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932152AbWEWUdV convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:33:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CzbUlvCUwCpUj84k+txObIGPOB9i37eDY/9qzVofLATNhnWdtaq/jqNK8zgYfBff3y4VfqvSGOnn+0xzi1Z2Gh3gBnaD8Y6EKvHjt8k+LpxrS2j8ebI6vRNDPKrWecG3BWJpkqjRHcbBvBMUDSWHfrojZV0uAAAiBXcfFLofIuY=
Message-ID: <6bffcb0e0605231333n612da806j9bd910cba65e3692@mail.gmail.com>
Date: Tue, 23 May 2006 22:33:20 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Alexey Polyakov" <alexey.polyakov@gmail.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing more than 4k at a time (has implications for generic write code and eventually for the IO layer)
Cc: "Hans Reiser" <reiser@namesys.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>,
       "Reiserfs developers mail-list" <Reiserfs-Dev@namesys.com>,
       "Reiserfs mail-list" <Reiserfs-List@namesys.com>,
       "Nate Diller" <ndiller@namesys.com>
In-Reply-To: <b5d90b2a0605231326g5319fea8wb9efef34ee5f7ec6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44736D3E.8090808@namesys.com>
	 <b5d90b2a0605231326g5319fea8wb9efef34ee5f7ec6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 23/05/06, Alexey Polyakov <alexey.polyakov@gmail.com> wrote:
> Hi!
>
> I'm actively using Reiser4 on a production servers (and I know a lot
> of people that do that too).
> Could you please release the patch against the vanilla tree?
> I don't think there's a lot of people that will test -mm version,
> especially on production servers - -mm is a little bit too unstable.

Any chance to get this patch against 2.6.17-rc4-mm3?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
