Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVAEBdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVAEBdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVAEBcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:32:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3051 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262222AbVAEBap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:30:45 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1104878646.17166.63.camel@localhost.localdomain>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>  <87u0pxhvn0.fsf@sulphur.joq.us>
	 <1104865198.8346.8.camel@krustophenia.net>
	 <1104878646.17166.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 20:30:44 -0500
Message-Id: <1104888644.18410.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 00:01 +0000, Alan Cox wrote:
> The problem with uid/gid based hacks is that they get really ugly to
> administer really fast. Especially once you have users who need realtime
> and hugetlb, and users who need one only.

Why?  Just make a realtime group and a hugetlb group and add users to
one, the other, or both.

Lee

