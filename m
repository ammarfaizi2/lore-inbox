Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWCCXch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWCCXch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWCCXch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:32:37 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:55868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932591AbWCCXcg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:32:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vc5A1LGqb+x6prQp6CHpDz5XXzZdNFFUur6xHKIwlxAL7U734EXCZZ4H4d6yulXnE0VSi+EDUuQwpUWGRlgwL5dQYsxFGZEpQ0zNAZhvCraFjn8z5dnNXEpg1khKCuJJcBsE7qofiY/JXNwLxtEjBmgqzarXkmnjRR79o3BcACU=
Message-ID: <41b516cb0603031532n517f78efh932d452648574d2@mail.gmail.com>
Date: Fri, 3 Mar 2006 15:32:29 -0800
From: "Chris Leech" <chris.leech@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <54FF0817-23ED-47F1-8234-FD3079B3E403@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303214036.11908.10499.stgit@gitlost.site>
	 <54FF0817-23ED-47F1-8234-FD3079B3E403@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> How does this relate to Dan William's ADMA work?

I only became aware of Dan's ADMA work when he posted it last month,
and so far have not made any attempts to merge the I/OAT code with it.
 Moving forward, combining these interfaces certainly seems like the
right way to go.  I particularly like ADMA's handling of operations
other than just a copy (memset, compare, XOR, CRC).

Chris
