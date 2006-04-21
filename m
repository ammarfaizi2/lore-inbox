Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWDUNcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWDUNcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWDUNcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:32:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:26277 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932298AbWDUNcw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:32:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJ+pAFVVu6C56qg9ZI6Znr9q1YpXvQSzh0B0ZvAVuTjq+CSiYUZgN7smGBTlRVo+i9kVWIEhYMA8L6l2xU47xiPSHcLqhZ5Pa074tsBjXj8n0ERV5iNpHcmAvp/kpcOvKvnb2a6Q2lC0Oz99l0e4DtNwafZb7g/SsYLhWGXn5Go=
Message-ID: <84144f020604210632n62ee6eafs147be14b1f46b8f9@mail.gmail.com>
Date: Fri, 21 Apr 2006 16:32:51 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Michael Holzheu" <holzheu@de.ibm.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20060421133541.37002378.holzheu@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060421133541.37002378.holzheu@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/06, Michael Holzheu <holzheu@de.ibm.com> wrote:
> When the file system is mounted the accounting information is retrieved
> and a file system tree is created with the attribute files containing
> the cpu information. The content of the files remains unchanged until a
> new update is  made. An update can be triggered from user space through
> writing 'something' into a special purpose update file.

Why are you caching the data?

                                       Pekka
