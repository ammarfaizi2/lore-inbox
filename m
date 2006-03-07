Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWCGBEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWCGBEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWCGBEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:04:20 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:49343 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932574AbWCGBET convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:04:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WqWtXeAmsLYJsy/B7cq4jrzKmqkbQFUEI92dYGGliAJEStgr9cSmIiSscP8v3HYaRot6cMmiG051/wLaKRZk/M+taLqopUY2WIZ+2eNehwHayFWZsb4e7Jy8YAKNuEGFh9Ck3cmPkwM5v1S1jCSLIuhUSP88K0bQYBv7QyjrQDM=
Message-ID: <a4e6962a0603061704o2eb3ef72t59f1b535ade1dd82@mail.gmail.com>
Date: Mon, 6 Mar 2006 19:04:17 -0600
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 9pfs double kfree
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org,
       rminnich@lanl.gov, "Latchesar Ionkov" <lucho@ionkov.net>
In-Reply-To: <20060306163745.65e0f4d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306070456.GA16478@redhat.com>
	 <20060306163745.65e0f4d8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Andrew Morton <akpm@osdl.org> wrote:
>
> So I'll duck on this - Eric, could you please handle it?  Consider doing
> away with the dynamically-allocated thing altogether and just allocating it
> on the outermost caller's stack.
>

Sure - Lucho may have already caught these, he's got a couple of
patches in the queue and he reported fixing some problems of this
nature that were in our recent patches.

             -eric
