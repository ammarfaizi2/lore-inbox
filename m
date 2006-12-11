Return-Path: <linux-kernel-owner+w=401wt.eu-S937541AbWLKSyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937541AbWLKSyg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937563AbWLKSyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:54:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:31759 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937541AbWLKSyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:54:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ok5CPVvzmeRWzAKS49Q6fUJ9SHF/Xbj3uBDP9Lf2Ne6NKG6nYMZBzEVXyATwr92mXXgEORattEYI5mXDM8SrW7Ey6hdcr+NDFk9Wpa9Js6AE812I6pFaBpa+W0B5kkuNTl/I6ca+0Dr80tXh1oqCSWz929uaDbHhvoDIpNBVcs0=
Message-ID: <a4e6962a0612111054j6741c70cja1aa96ebee124e63@mail.gmail.com>
Date: Mon, 11 Dec 2006 12:54:33 -0600
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "Eric Van Hensbergen" <ericvh@hera.kernel.org>
Subject: Re: [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, ming@acis.ufl.edu
In-Reply-To: <200611271826.kARIQYRi032717@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611271826.kARIQYRi032717@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/06, Eric Van Hensbergen <ericvh@hera.kernel.org> wrote:
> This is the first cut of a device-mapper target which provides a write-back
> or write-through block cache.  It is intended to be used in conjunction with
> remote block devices such as iSCSI or ATA-over-Ethernet, particularly in
> cluster situations.
>

The technical paper describing our motivations and some performance
results has finally made it through IBM's clearance process.  It is
available here:

http://domino.research.ibm.com/library/cyberdig.nsf/1e4115aea78b6e7c85256b360066f0d4/ba52bef8b940e7438525723c006bafea?OpenDocument

               -eric
