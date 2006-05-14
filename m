Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWENOzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWENOzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWENOzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:55:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:62549 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751437AbWENOzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:55:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UZBi+JR0Qa9mYbgzkphl6FHvSIATyn8s5xSgERCxiAiakEZgyySVAtGQ1V7uBbnZa+XV+Yk1oRL0FqR5v02IEn+KKkgCJjBTA0M9WGWALf9+ijLE+coaqZNijFzD6QiRrSAWMq77Fa6WnXeKysdkrn31kjKSCrUUKFtG5O2grRI=
Message-ID: <84144f020605140755w4c64dc14o8beda9f5bbb68b9c@mail.gmail.com>
Date: Sun, 14 May 2006 17:55:46 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513160625.8848.76947.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160625.8848.76947.stgit@localhost.localdomain>
X-Google-Sender-Auth: 0c13789dceeaf487
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> There are allocations for which the main pointer cannot be found but they
> are not memory leaks. This patch fixes some of them.

Why can't they be found? How many false positives are you expecting?

                                       Pekka
