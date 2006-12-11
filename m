Return-Path: <linux-kernel-owner+w=401wt.eu-S937041AbWLKS5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937041AbWLKS5H (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763009AbWLKS5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:57:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:35962 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937515AbWLKS5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:57:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JqMPXMLCIoAJ393zVOWT9lWOjlOR5tUJk9pdyWNHgfRRT0YXsgsbnaJt6U3fB/BYEaEaaAa3qF6TXfOKWwTrVkslKHQ6exzy2rOx7Y1OHygQyRAkfaIKAmwK2XK1dAjnZ9WdWg4GVVj+EVgBcxHKu4+q7qmJzQZMWGspTIVshXs=
Message-ID: <a4e6962a0612111057i48993e19j5048ac26b96f4714@mail.gmail.com>
Date: Mon, 11 Dec 2006 12:57:03 -0600
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "Eric Van Hensbergen" <ericvh@hera.kernel.org>
Subject: Re: [RFC][PATCH] dm-cow: copy-on-write stackable target for device-mapper
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, paurea@gmail.com
In-Reply-To: <200611271659.kARGx5qb017564@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611271659.kARGx5qb017564@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/06, Eric Van Hensbergen <ericvh@hera.kernel.org> wrote:
> Subject: [RFC] [PATCH] dm-cow: copy-on-write stackable target for device-mapper
>
> This is the first cut of a device-mapper target which allows stacking of
> multiple block devices and in which the top-layer of the stack is a
> copy-on-write layer.  It was originally developed in support of a cluster
> image management solution.
>

The paper describing our motivation for this work including some
description of this implementation and performance results is now
available:

http://domino.research.ibm.com/library/cyberdig.nsf/1e4115aea78b6e7c85256b360066f0d4/801d563d3be022198525723c006fafc1?OpenDocument

           -eric
